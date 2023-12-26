include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/../../resources/aws-managed/postgres"
}

dependency "core_lookup" {
  config_path = "../../core-lookup"
}

inputs = {
  allocated_storage                   = 20
  app_name                            = "karaoke"
  aws_iam_openid_connect_provider_arn = dependency.core_lookup.outputs.aws_iam_openid_connect_provider_arn
  aws_region                          = "us-east-1"
  cluster_certificate_authority_data  = dependency.core_lookup.outputs.cluster_certificate_authority_data
  db_engine                           = "postgres"
  db_engine_version                   = "15.3"
  db_instance_type                    = "db.t3.medium"
  db_port                             = "5432"
  db_storage_type                     = "gp3"
  db_subnet_ids                       = dependency.core_lookup.outputs.db_subnet_ids  
  eks_cluster_endpoint                = dependency.core_lookup.outputs.eks_cluster_endpoint
  eks_cluster_id                      = dependency.core_lookup.outputs.eks_cluster_id
  environment                         = "dev"
  migrations_dir                      = "migrations"
  private_subnets_cidr_blocks         = dependency.core_lookup.outputs.private_subnets_cidr_blocks
  postgres_username                   = "singers_app"
  public_subnets_cidr_blocks          = dependency.core_lookup.outputs.public_subnets_cidr_blocks
  vpc_id                              = dependency.core_lookup.outputs.vpc_id
}

skip = false 