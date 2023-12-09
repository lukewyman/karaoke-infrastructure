include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/../../resources/aws-managed/documentdb"
}

dependency "core_lookup" {
  config_path = "../../core-lookup"
}

inputs = {
  app_name                           = "karaoke"
  aws_region                         = "us-east-1"
  cluster_certificate_authority_data = dependency.core_lookup.outputs.cluster_certificate_authority_data
  docdb_engine_version               = "4.0.0"
  docdb_instance_class               = "db.t3.medium"
  docdb_instance_count               = 1
  docdb_port                         = "27017"
  docdb_subnet_ids                   = dependency.core_lookup.outputs.db_subnet_ids
  eks_cluster_endpoint               = dependency.core_lookup.outputs.eks_cluster_endpoint
  eks_cluster_id                     = dependency.core_lookup.outputs.eks_cluster_id
  environment                        = "dev"
  private_subnets_cidr_blocks        = dependency.core_lookup.outputs.private_subnets_cidr_blocks
  public_subnets_cidr_blocks         = dependency.core_lookup.outputs.public_subnets_cidr_blocks
  vpc_id                             = dependency.core_lookup.outputs.vpc_id
}