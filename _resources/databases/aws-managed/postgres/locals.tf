locals {
  app_name = "${var.app_name}-${var.environment}"

  postgres_user = "postgres"

  flyway_db_url = "jdbc:postgresql://${kubernetes_service_v1.postgres_service.metadata.0.name}:${var.db_port}/postgres"
}