include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/_resources/migrations/mongo"
}

dependency "eks_cluster" {
  config_path = "${get_terragrunt_dir()}/../../core/eks-cluster"

  mock_outputs = {
    aws_iam_openid_connect_provider_arn = "mock_oicd_arn"
    cluster_certificate_authority_data  = "bW9ja19jZXJ0X2F1dGhfZGF0YQ=="
    eks_cluster_endpoint                = "mock_cluster_endpoint"
    eks_cluster_id                      = "mock_cluster_id"
  }
}

dependency "mongo" {
  config_path = "${get_terragrunt_dir()}/../../databases/mongo"

  mock_outputs = {
    mongo_service_name = "mock_service_name"
  }
}

inputs = {
  app_name                            = "karaoke"
  app_username                        = "singers_app"
  aws_region                          = "us-east-1"
  aws_iam_openid_connect_provider_arn = dependency.eks_cluster.outputs.aws_iam_openid_connect_provider_arn
  cluster_certificate_authority_data  = dependency.eks_cluster.outputs.cluster_certificate_authority_data
  eks_cluster_endpoint                = dependency.eks_cluster.outputs.eks_cluster_endpoint
  eks_cluster_id                      = dependency.eks_cluster.outputs.eks_cluster_id
  environment                         = "cicd"
  migrations_dir                      = "migrations"
  mongo_service_name                  = "karaoke-cicd-mongodb"
  db_port                             = "27017"
  service_account_name                = ""
  service_name                        = "song-library"
}