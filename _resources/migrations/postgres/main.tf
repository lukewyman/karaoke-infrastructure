resource "kubernetes_job_v1" "postgres_migrations" {
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
          image = "flyway/flyway"
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

resource "aws_ssm_parameter" "postgres_app_user" {
  name = "/app/${var.app_name}/${var.environment}/app_user"
  type = "String"
  value = var.app_user
}

resource "aws_ssm_parameter" "postgres_app_password" {
  name = "/app/${var.app_name}/${var.environment}/app_password"
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
    "V1_1_create_user.sql"      = data.template_file.create_user.rendered
    "V1_2_create_db.sql"        = data.template_file.create_db.rendered
    "V1_3_grant_privileges.sql" = data.template_file.grant_privileges.rendered
    "V1_4_create_tables.sql"    = data.template_file.create_tables.rendered
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