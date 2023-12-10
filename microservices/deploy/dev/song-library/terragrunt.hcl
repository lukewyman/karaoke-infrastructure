include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/../../resources/microservice"
}

dependency "core_lookup" {
  config_path = "../../core-lookup"
}

dependency "db_lookup" {
  config_path = "../databases-lookup"
}

inputs = {
  app_name                           = "karaoke"
  aws_iam_openid_connect_provider_arn = dependency.core_lookup.outputs.aws_iam_openid_connect_provider_arn
  aws_region                         = "us-east-1"
  cluster_certificate_authority_data = dependency.core_lookup.outputs.cluster_certificate_authority_data
  container_port                     = 8081
  eks_cluster_endpoint               = dependency.core_lookup.outputs.eks_cluster_endpoint
  eks_cluster_id                     = dependency.core_lookup.outputs.eks_cluster_id
  environment                        = "dev"
  iam_policy_arns                    = [
    "arn:aws:iam::aws:policy/AmazonDocDBFullAccess"
  ]
  image_repository_name              = "karaoke-image-dev-song-library"
  image_version                      = "v1"
  mongo_port                         = "27017"
  namespace_root                     = "karaoke"
  node_port                          = "31281"
  service_name                       = "song-library"
}
