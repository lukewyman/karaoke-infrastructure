data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.eks_cluster_id
}

data "aws_ssm_parameter" "admin_username" {
  name = "/app/${var.app_name}/${var.environment}/mongo/USERNAME"
}

data "aws_ssm_parameter" "admin_password" {
  name            = "/app/${var.app_name}/${var.environment}/mongo/PASSWORD"
  with_decryption = true
}