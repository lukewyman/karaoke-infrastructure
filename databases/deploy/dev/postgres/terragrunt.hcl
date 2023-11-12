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
  allocated_storage           = 20
  app_name                    = "karaoke"
  aws_region                  = "us-east-1"
  db_engine                   = "postgres"
  db_engine_version           = "15.3"
  db_instance_type            = "db.t3.medium"
  db_port                     = "5432"
  db_storage_type             = "gp3"
  db_subnet_ids               = dependency.core_lookup.outputs.db_subnet_ids
  environment                 = "dev"
  private_subnets_cidr_blocks = dependency.core_lookup.outputs.private_subnets_cidr_blocks
  public_subnets_cidr_blocks  = dependency.core_lookup.outputs.public_subnets_cidr_blocks
  vpc_id                      = dependency.core_lookup.outputs.vpc_id
}