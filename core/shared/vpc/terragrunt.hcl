include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/_resources/core/vpc"
}

inputs = {
  app_name                               = "karaoke"
  aws_region                             = "us-east-1"
  environment                            = "shared"
  vpc_cidr_block                         = "10.0.0.0/16"
  vpc_create_database_subnet_route_table = true
  vpc_database_subnets                   = ["10.0.151.0/24", "10.0.152.0/24"]
  vpc_enable_nat_gateway                 = true
  vpc_private_subnets                    = ["10.0.101.0/24", "10.0.102.0/24"]
  vpc_public_subnets                     = ["10.0.1.0/24", "10.0.2.0/24"]
  vpc_single_nat_gateway                 = true
}
