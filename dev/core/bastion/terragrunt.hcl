include "root" {
  path = find_in_parent_folders()
}

include "bastion" {
  path = "${get_terragrunt_dir()}/../../../_env/bastion.hcl"
}

inputs = {
  environment = "dev"
}
