locals {
  app_name = "${var.app_name}-${var.environment}"

  migrations = fileset("${path.module}/${var.migrations_dir}", "*.sql")

  flyway_db_url = "jdbc:postgresql://${kubernetes_service_v1.postgres_service.metadata.0.name}:${var.db_port}/postgres"

  service_account_name = "postgres-full-access"
}