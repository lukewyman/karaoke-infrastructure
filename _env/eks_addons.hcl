terraform {
  source = "github.com/lukewyman/karaoke-resources.git//core/eks-addons?ref=main"
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

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    vpc_id = "mock_vpc_id"
  }
}

inputs = {
  aws_region                          = "us-east-1"
  app_name                            = "karaoke"
  cluster_certificate_authority_data  = dependency.eks_cluster.outputs.cluster_certificate_authority_data
  eks_cluster_endpoint                = dependency.eks_cluster.outputs.eks_cluster_endpoint
  eks_cluster_id                      = dependency.eks_cluster.outputs.eks_cluster_id
  aws_iam_openid_connect_provider_arn = dependency.eks_cluster.outputs.aws_iam_openid_connect_provider_arn
  vpc_id                              = dependency.vpc.outputs.vpc_id
}