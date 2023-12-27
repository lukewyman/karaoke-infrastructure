data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = var.bucket 
    key = "core/${var.environment}/vpc"
    region = var.aws_region 
  }
}

data "terraform_remote_state" "eks_cluster" {
  backend = "s3"

  config = {
    bucket = var.bucket 
    key = "core/${var.environment}/eks-cluster"
    region = var.aws_region 
  }
}