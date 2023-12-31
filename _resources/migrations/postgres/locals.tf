locals {
  app_name = "${var.app_name}-${var.environment}"

  migrations = fileset("${path.module}/${var.migrations_dir}", "*.sql")

  flyway_db_url = "jdbc:postgresql://${var.postgres_service_name}:${var.db_port}/postgres"
}