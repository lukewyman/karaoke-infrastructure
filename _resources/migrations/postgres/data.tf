data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.eks_cluster_id
}

data "template_file" "create_user" {
  template = file("${path.module}/${var.migrations_dir}/V1_1_create_user.tpl")
  vars = {
    username = var.app_user
    password = aws_ssm_parameter.postgres_app_password.value
  }
}

data "template_file" "create_db" {
  template = file("${path.module}/${var.migrations_dir}/V1_2_create_db.tpl")
  vars = {
    username = var.app_user
  }
}

data "template_file" "grant_privileges" {
  template = file("${path.module}/${var.migrations_dir}/V1_3_grant_privileges.tpl")
  vars = {
    username = var.app_user
  }
}

data "template_file" "create_tables" {
  template = file("${path.module}/${var.migrations_dir}/V1_4_create_tables.tpl")
  vars = {
    username = var.app_user
  }
}

data "aws_ssm_parameter" "postgres_password" {
  name = "/app/${var.app_name}/${var.environment}/POSTGRES_PASSWORD"
  with_decryption = true 
}