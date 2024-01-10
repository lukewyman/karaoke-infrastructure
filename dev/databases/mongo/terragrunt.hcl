include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/_resources/databases/aws-managed/documentdb"
}

dependency "eks_cluster" {
  config_path = "${get_terragrunt_dir()}/../../core/eks-cluster"

  mock_outputs = {
    cluster_certificate_authority_data  = "bW9ja19jZXJ0X2F1dGhfZGF0YQ=="
    eks_cluster_endpoint                = "mock_cluster_endpoint"
    eks_cluster_id                      = "mock_cluster_id"
    aws_iam_openid_connect_provider_arn = "mock_oicd_arn"
  }
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
  app_name                            = "karaoke"
  aws_iam_openid_connect_provider_arn = dependency.eks_cluster.outputs.aws_iam_openid_connect_provider_arn
  aws_region                          = "us-east-1"
  cluster_certificate_authority_data  = dependency.eks_cluster.outputs.cluster_certificate_authority_data
  docdb_engine_version                = "4.0.0"
  docdb_instance_class                = "db.t3.medium"
  docdb_instance_count                = 1
  docdb_port                          = "27017"
  docdb_subnet_ids                    = dependency.vpc.outputs.database_subnets
  docdb_username                      = "karaoke_app"
  eks_cluster_endpoint                = dependency.eks_cluster.outputs.eks_cluster_endpoint
  eks_cluster_id                      = dependency.eks_cluster.outputs.eks_cluster_id
  environment                         = "dev"
  private_subnets_cidr_blocks         = dependency.vpc.outputs.private_subnets_cidr_blocks
  public_subnets_cidr_blocks          = dependency.vpc.outputs.public_subnets_cidr_blocks
  vpc_id                              = dependency.vpc.outputs.vpc_id
}

skip = false