include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "github.com/lukewyman/karaoke-resources.git//databases/aws-managed/postgres?ref=main"
}

include "postgres" {
  path = "${get_terragrunt_dir()}/../../../_env/postgres.hcl"
}

dependency "vpc" {
  config_path = "${get_terragrunt_dir()}/../../core/vpc"

  mock_outputs = {
    database_subnets            = ["mock_subnet_1", "mock_subnet_2"]
    public_subnets              = ["mock_subnet_3", "mock_subnet_4"]
    private_subnets_cidr_blocks = ["0.0.0.0/0", "0.0.0.0/0"]
    public_subnets_cidr_blocks  = ["0.0.0.0/0", "0.0.0.0/0"]
    vpc_id                      = "mock_vpc_id"
  }
}

inputs = {
  allocated_storage                   = 20
  aws_iam_openid_connect_provider_arn = dependency.eks_cluster.outputs.aws_iam_openid_connect_provider_arn
  db_engine                           = "postgres"
  db_engine_version                   = "15.3"
  db_instance_type                    = "db.t3.medium"
  db_port                             = "5432"
  db_storage_type                     = "gp3"
  db_subnet_ids                       = dependency.vpc.outputs.database_subnets
  environment                         = "dev"
  migrations_dir                      = "migrations"
  private_subnets_cidr_blocks         = dependency.vpc.outputs.private_subnets_cidr_blocks
  postgres_app_username               = "something for now"
  postgres_username                   = "singers_app"
  public_subnets_cidr_blocks          = dependency.vpc.outputs.public_subnets_cidr_blocks
  vpc_id                              = dependency.vpc.outputs.vpc_id
}

skip = false 