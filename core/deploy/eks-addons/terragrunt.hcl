include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/../resources/eks-addons"
}

dependency "eks_cluster" {
  config_path = "../eks-cluster"

  mock_outputs = {
    cluster_certificate_authority_data  = "bW9ja19jZXJ0X2F1dGhfZGF0YQ=="
    eks_cluster_endpoint                = "mock_cluster_endpoint"
    eks_cluster_id                      = "mock_cluster_id"
    aws_iam_openid_connect_provider_arn = "mock_oicd_arn"
  }
}

inputs = {
  aws_region                          = "us-east-1"
  app_name                            = "karaoke"
  cluster_certificate_authority_data  = dependency.eks_cluster.outputs.cluster_certificate_authority_data
  eks_cluster_endpoint                = dependency.eks_cluster.outputs.eks_cluster_endpoint
  eks_cluster_id                      = dependency.eks_cluster.outputs.eks_cluster_id
  environment                         = "shared"
  aws_iam_openid_connect_provider_arn = dependency.eks_cluster.outputs.aws_iam_openid_connect_provider_arn
}