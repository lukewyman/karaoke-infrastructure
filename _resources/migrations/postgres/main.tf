resource "kubernetes_job_v1" "postgres_migrations" {
  depends_on = [ kubernetes_config_map_v1.migration_files ]
  
  metadata {
    name      = "postgres-migrations"
    namespace = local.app_name
  }

  spec {
    template {
      metadata {
        name = "postgres-migrations"
      }
      spec {
        service_account_name = var.service_account_name

        container {
          name  = "postgres-migrations"
          image = "flyway/flyway:10.4-alpine"
          args  = ["migrate"]

          env {
            name  = "FLYWAY_URL"
            value = local.flyway_db_url
          }
          env {
            name  = "FLYWAY_USER"
            value = "postgres"
          }
          env {
            name = "FLYWAY_MIXED"
            value = true
          }
          env {
            name = "FLYWAY_PASSWORD"
            value_from {
              secret_key_ref {
                name = kubernetes_secret_v1.postres_password.metadata.0.name
                key  = "POSTGRES_PASSWORD"
              }
            }
          }

          volume_mount {
            name       = "sql"
            mount_path = "/flyway/sql"
          }
        }
        volume {
          name = "sql"
          config_map {
            name = kubernetes_config_map_v1.migration_files.metadata.0.name
          }
        }
        restart_policy = "OnFailure"
      }
    }
  }
}

resource "aws_ssm_parameter" "app_username" {
  name = "/app/${var.app_name}/${var.environment}/${var.service_name}/USERNAME"
  type = "String"
  value = var.app_username
}

resource "aws_ssm_parameter" "app_password" {
  name = "/app/${var.app_name}/${var.environment}/${var.service_name}/PASSWORD"
  type = "SecureString"
  value = random_password.password.result
}

resource "random_password" "password" {
  length  = 8
  special = false
}

resource "kubernetes_config_map_v1" "migration_files" {
  metadata {
    name      = "postgres-migrations-files"
    namespace = local.app_name
  }

  data = {
    "V1__init_db.sql"      = templatefile("${path.module}/${var.migrations_dir}/V1__init_db.tftpl", {
      app_username = aws_ssm_parameter.app_username.value,
      app_password = aws_ssm_parameter.app_password.value
    })
  }
}

resource "kubernetes_secret_v1" "postres_password" {
  metadata {
    name      = "postgres-password"
    namespace = "${var.app_name}-${var.environment}"
  }

  data = {
    "POSTGRES_PASSWORD" = data.aws_ssm_parameter.postgres_password.value
  }
}