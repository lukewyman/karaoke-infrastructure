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
  config_path = "../databases-lookup"
}

inputs = {
  aws_region                         = "us-east-1"
  cluster_certificate_authority_data = dependency.core_lookup.outputs.cluster_certificate_authority_data
  container_port                     = 8081
  eks_cluster_endpoint               = dependency.core_lookup.outputs.eks_cluster_endpoint
  eks_cluster_id                     = db_lookup.core_lookup.outputs.eks_cluster_id
  image_repository_name              = "karaoke-image-dev-song-library"
  image_version                      = "v1"
  mongo_port                         = "27017"
  node_port                          = "31281"
  service_name                       = "song-library"
}

# TODOs:
# 1. ENV variables for databases in microservices
# 2. use "data" "aws_ecr_repository" for image uri output instead of image uri direct use
# 3. sort out the lookups for core and dbs
# 4. ensure db usernames and passwords are correctly setup
# 5. check IAM permissions for ECR, KMS, etc.