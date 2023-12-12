include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/../../resources/ingress"
}

dependency "core_lookup" {
  config_path = "../../core-lookup"

  mock_outputs = {
    aws_iam_openid_connect_provider_arn = "mock_oicd_arn"
    cluster_certificate_authority_data  = "bW9ja19jZXJ0X2F1dGhfZGF0YQ=="
    eks_cluster_endpoint                = "mock_cluster_endpoint"
    eks_cluster_id                      = "mock_cluster_id"
  }
}

inputs = {
  app_name                            = "karaoke"
  aws_iam_openid_connect_provider_arn = dependency.core_lookup.outputs.aws_iam_openid_connect_provider_arn
  aws_region                          = "us-east-1"
  cluster_certificate_authority_data  = dependency.core_lookup.outputs.cluster_certificate_authority_data
  eks_cluster_endpoint                = dependency.core_lookup.outputs.eks_cluster_endpoint
  eks_cluster_id                      = dependency.core_lookup.outputs.eks_cluster_id
  environment                         = "dev"
  routes = {
    "song-library" = "songs"
    "singers"      = "singers"
    "rotations"    = "queues"
  }
}
