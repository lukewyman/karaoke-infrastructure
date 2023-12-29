include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/_resources/core/bastion"
}

include "bastion" {
  path = "${get_terragrunt_dir()}/../../../_env/bastion.hcl"
}

inputs = {
  environment = "dev"
}
