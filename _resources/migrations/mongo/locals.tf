locals {
  app_name = "${var.app_name}-${var.environment}"

  # init_db_bash_script = "mongosh --host ${var.mongo_service_name} --port ${var.db_port} --username  --password password1  --file create_db.js"

  init_db_bash_script = join(" ", [
    "mongosh --host ${var.mongo_service_name}",
    "--port ${var.db_port}",
    "--username ${data.aws_ssm_parameter.admin_username.value}",
    "--password ${data.aws_ssm_parameter.admin_password.value}",
    "--file /opt/init_db.js"
  ])

  migrations = fileset("${path.module}/${var.migrations_dir}", "*.sql")

}