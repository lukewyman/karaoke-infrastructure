locals {
  app_name = "${var.app_name}-${var.environment}"

  migrations = fileset("${path.module}/${var.migrations_dir}", "*.sql")

  init_db_bash_script = join("", [
    "psql -f /opt/init-db.sql ",
    "postgresql://postgres:${data.aws_ssm_parameter.postgres_password.value}",
    "@${var.postgres_service_name}:${var.db_port}/postgres"
  ])

  create_table_bash_script = join("", [
    "psql -f /opt/create-tables.sql ",
    "postgresql://${aws_ssm_parameter.app_username.value}:${aws_ssm_parameter.app_password.value}",
    "@${var.postgres_service_name}:${var.db_port}/singers"
  ])
}