include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "github.com/lukewyman/karaoke-resources.git//databases/statefulsets/postgres?ref=main"
}

dependency "eks_cluster" {
  config_path = "${get_terragrunt_dir()}/../../core/eks-cluster"

  mock_outputs = {
    cluster_certificate_authority_data  = "bW9ja19jZXJ0X2F1dGhfZGF0YQ=="
    eks_cluster_endpoint                = "mock_cluster_endpoint"
    eks_cluster_id                      = "mock_cluster_id"
    aws_iam_openid_connect_provider_arn = "mock_oicd_arn"
  }
}

inputs = {
  app_name                           = "karaoke"
  aws_region                         = "us-east-1"
  cluster_certificate_authority_data = dependency.eks_cluster.outputs.cluster_certificate_authority_data
  eks_cluster_endpoint               = dependency.eks_cluster.outputs.eks_cluster_endpoint
  eks_cluster_id                     = dependency.eks_cluster.outputs.eks_cluster_id
  environment                        = "cicd"
}