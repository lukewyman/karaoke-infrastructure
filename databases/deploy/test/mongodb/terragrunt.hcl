include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/../../resources/statefulsets/mongodb"
}

dependency "core_lookup" {
  config_path = "../../core-lookup"
}

inputs = {
  app_name = "karaoke"
  aws_region                         = "us-east-1"  
  cluster_certificate_authority_data = dependency.core_lookup.outputs.cluster_certificate_authority_data
  eks_cluster_endpoint               = dependency.core_lookup.outputs.eks_cluster_endpoint
  eks_cluster_id                     = dependency.core_lookup.outputs.eks_cluster_id
  environment                        = "test"
}