resource "kubernetes_storage_class_v1" "ebs_sc" {
  metadata {
    name = "ebs-sc"
  }

  storage_provisioner = "ebs.csi.aws.com"
  volume_binding_mode = "WaitForFirstConsumer"
}

resource "kubernetes_persistent_volume_claim_v1" "postgres" {
  metadata {
    name = "ebs-mysql-pv-claim"
  }

  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = kubernetes_storage_class_v1.ebs_sc.metadata.0.name

    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }
}

resource "kubernetes_config_map_v1" "config_map" {
  metadata {
    name = "db-creation-script"
  }

  data = {
    "init" = "${file("${path.module}/sql/init-postgres.sql")}"
  }
}

resource "kubernetes_secret_v1" "postgres_password" {
  metadata {
    name = "postgres-password"
  }

  data = {
    POSTGRES_PASSWORD = aws_ssm_parameter.postgres_password.value
  }
}

resource "aws_ssm_parameter" "postgres_password" {
  name  = "/app/karaoke/${var.environment}/POSTGRES_PASSWORD"
  type  = "SecureString"
  value = random_password.password.result
}

resource "random_password" "password" {
  length  = 8
  special = false
}

resource "kubernetes_stateful_set_v1" "postgres_stateful_set" {

  metadata {
    name = "postgres"
    labels = {
      app = "postgres"
    }
  }

  spec {
    replicas     = 1
    service_name = "postgres"

    selector {
      match_labels = {
        "app" = "postgres"
      }
    }

    template {
      metadata {
        labels = {
          app = "postgres"
        }
      }

      spec {
        termination_grace_period_seconds = 5

        volume {
          name = "postgres-persistent-storage"
          persistent_volume_claim {
            claim_name = "ebs-mysql-pv-claim"
          }
        }

        volume {
          name = "db-init-script"
          config_map {
            name = kubernetes_config_map_v1.config_map.metadata.0.name
          }
        }

        container {
          name              = "postgres"
          image             = "postgres:13"
          image_pull_policy = "IfNotPresent"

          port {
            container_port = "5432"
          }

          env_from {
            secret_ref {
              name = kubernetes_secret_v1.postgres_password.metadata.0.name
            }
          }

          volume_mount {
            mount_path = "/var/lib/postgresql/data"
            name       = "postgres-persistent-storage"
          }

          volume_mount {
            mount_path = "/docker-entrypoint-initdb.d"
            name       = "db-init-script"
          }

          resources {
            requests = {
              memory = "64Mi"
              cpu    = "500m"
            }

            limits = {
              memory = "128Mi"
              cpu    = "500m"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "postgres_service" {

  metadata {
    name = "postgres"

    labels = {
      app = "postgres"
    }
  }

  spec {
    type = "ClusterIP"

    selector = {
      app = kubernetes_stateful_set_v1.postgres_stateful_set.metadata.0.labels.app
    }

    port {
      port = "5432"
    }
  }
}