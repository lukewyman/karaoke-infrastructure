include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/_resources/core/vpc"
}

include "vpc" {
  path = "${get_terragrunt_dir()}/../../../_env/vpc.hcl"
}

inputs = {
  environment = "dev"
}