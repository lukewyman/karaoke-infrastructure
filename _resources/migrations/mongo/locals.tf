locals {
  app_name = "${var.app_name}-${var.environment}"

  migrations = fileset("${path.module}/${var.migrations_dir}", "*.sql")

}