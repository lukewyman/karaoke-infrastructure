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
          name    = "postgres-migrations"
          image   = "postgres:12.17-alpine3.19"
          command = ["bin/bash", "-c", "${local.init_db_bash_script};${local.create_table_bash_script};"]
          volume_mount {
            name = "migrations"
            mount_path = "/opt"
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
    name      = "postgres-migration-files"
    namespace = local.app_name
  }

  data = {
    "init-db.sql" = templatefile("${path.module}/${var.migrations_dir}/init_db.tftpl", {
      app_username   = aws_ssm_parameter.app_username.value,
      app_password   = aws_ssm_parameter.app_password.value
    })

    "create-tables.sql" = file("${path.module}/${var.migrations_dir}/create_tables.sql")
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
    name = "postgres-app-password"
    namespace = local.app_name
  }

  data = {
    PGPASSWORD = aws_ssm_parameter.app_password.value
  }
}