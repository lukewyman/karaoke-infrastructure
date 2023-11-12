include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/../resources/bastion"
}

dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  app_name         = "karaoke"
  aws_region       = "us-east-1"
  environment      = "shared"
  instance_keypair = "karaoke-key-pair"
  instance_type    = "t3.small"
  subnet_ids       = dependency.vpc.outputs.public_subnets
  vpc_id           = dependency.vpc.outputs.vpc_id
}

skip = true