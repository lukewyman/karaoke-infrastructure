include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "github.com/lukewyman/karaoke-resources.git//databases/aws-managed/documentdb?ref=main"
}

include "mongo" {
  path = "${get_terragrunt_dir()}/../../../_env/mongo.hcl"
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
  aws_iam_openid_connect_provider_arn = dependency.eks_cluster.outputs.aws_iam_openid_connect_provider_arn
  docdb_engine_version                = "4.0.0"
  docdb_instance_class                = "db.t3.medium"
  docdb_instance_count                = 1
  docdb_port                          = "27017"
  docdb_subnet_ids                    = dependency.vpc.outputs.database_subnets
  docdb_username                      = "karaoke_app"
  environment                         = "dev"
  private_subnets_cidr_blocks         = dependency.vpc.outputs.private_subnets_cidr_blocks
  public_subnets_cidr_blocks          = dependency.vpc.outputs.public_subnets_cidr_blocks
  vpc_id                              = dependency.vpc.outputs.vpc_id
}

skip = false