resource "kubernetes_job_v1" "mongo_migrations" {
  metadata {
    name      = "mongo-migrations"
    namespace = local.app_name
  }

  spec {
    template {
      metadata {
        name = "mongo-migrations"
      }
      spec {
        service_account_name = var.service_account_name

        container {
          name    = "mongo-migrations"
          image   = "mongo:7.0.5-rc0"
          command = ["bin/bash", "-c", local.init_db_bash_script]
          volume_mount {
            name = "migrations"
            mount_path = "/opt"
          }

          env {
            name = "MONGO_ADMIN_USERNAME"
            value = data.aws_ssm_parameter.admin_password.value 
          }

          env_from {
            secret_ref {
              name = kubernetes_secret_v1.app_password.metadata.0.name
            }
          }
        }

        volume {
          name = "migrations"
          config_map {
            name = kubernetes_config_map_v1.migration_files.metadata.0.name
          }
        }
      }
    }
  }
}

resource "kubernetes_config_map_v1" "migration_files" {
  metadata {
    name      = "mongo-migration-files"
    namespace = local.app_name
  }

  data = {
    "init-db.js" = templatefile("${path.module}/${var.migrations_dir}/init_db.tftpl", {
      admin_username = data.aws_ssm_parameter.admin_username.value,
      admin_password = data.aws_ssm_parameter.admin_password.value,
      app_username   = aws_ssm_parameter.app_username.value,
      app_password   = aws_ssm_parameter.app_password.value
    })
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
  value = random_password.app_password.result
}

resource "random_password" "app_password" {
  length  = 8
  special = false
}

resource "kubernetes_secret_v1" "app_password" {
  metadata {
    name = "mongo-app-password"
    namespace = local.app_name
  }

  data = {
    MONGO_ADMIN_PASSWORD = aws_ssm_parameter.app_password.value
  }
}