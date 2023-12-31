include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/_resources/core/namespace"
}

include "namespace" {
  path = "${get_terragrunt_dir()}/../../../_env/namespace.hcl"
}

inputs = {
  environment = "dev"
}