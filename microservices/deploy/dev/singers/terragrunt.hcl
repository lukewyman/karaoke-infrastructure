include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/../../resources/microservices/microservice"
}

dependency "core_lookup" {
  config_path = "../../core-lookup"
}

dependency "db_lookup" {
  config_path = "../../databases-lookup"
}

inputs = {
  aws_region                         = "us-east-1"
  cluster_certificate_authority_data = dependency.core_lookup.outputs.cluster_certificate_authority_data
  container_port                     = 8081
  eks_cluster_endpoint               = dependency.core_lookup.outputs.eks_cluster_endpoint
  eks_cluster_id                     = db_lookup.core_lookup.outputs.eks_cluster_id
  image                              = "919980474747.dkr.ecr.us-east-1.amazonaws.com/karaoke-app-image-repos-dev-singers"
  image_version                      = "v1"
  node_port                          = ""
  service_name                       = "singers"
}

skip = true