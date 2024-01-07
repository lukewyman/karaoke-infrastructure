data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.eks_cluster_id
}

data "aws_ssm_parameter" "postgres_password" {
  name = "/app/${var.app_name}/${var.environment}/postgres/PASSWORD"
  with_decryption = true 
}