resource "kubernetes_job_v1" "postgres_migrations" {
  metadata {
    name = "postgres-migrations"
    namespace = "${var.app_name}-${var.environment}"
  }

  spec {
    template {
      metadata {
        name = "postgres-migrations"        
      }
      spec {
        service_account_name = local.service_account_name
        
        container {
          name = "postgres-migrations"
          image = "flyway/flyway"
          args = ["migrate"]

          env {
            name = "FLYWAY_URL"
            value = local.flyway_db_url
          }
          env {
            name = "FLYWAY_USER"
            value = var.postgres_user
          }
          env {
            name = "FLYWAY_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.postres_password.metadata.0.name 
                key = "POSTGRES_PASSWORD"
              }
            }
          }

          volume_mount {
            name = "sql"
            mount_path = "/flyway/sql"            
          }
        }
        volume {
          name = "sql"
          config_map {
            name = kubernetes_config_map_v1.migration_files.metadata.0.name
          }
        }
        restart_policy = "Never"
      }
    }
  }
}

resource "kubernetes_config_map_v1" "migration_files" {
  metadata {
    name = "postgres-migrations-files"
    namespace = "${var.app_name}-${var.environment}"
  }

  data = {for f in local.migrations: f => file("${var.migrations_dir}/${f}")}
}

resource "kubernetes_secret_v1" "postres_password" {
  metadata {
    name = "postgres-password"
    namespace = "${var.app_name}-${var.environment}"
  }

  data = {
    "POSTGRES_PASSWORD" = aws_ssm_parameter.postgres_password.value
  }
}