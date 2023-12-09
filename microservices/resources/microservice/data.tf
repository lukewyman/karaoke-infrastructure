data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.eks_cluster_id
}

data "aws_ecr_repository" "image_repository" {
  name = var.image_repository_name
}

data "aws_ssm_parameter" "mongo_username" {
  name = "/app/karaoke/DOCDB_USERNAME"
}

data "aws_ssm_parameter" "mongo_password" {
  name = "/app/karaoke/DOCDB_PASSWORD"
  with_decryption = true 
}