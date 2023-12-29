include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/_resources/core/eks-addons"
}

include "eks_addons" {
  path = "${get_terragrunt_dir()}/../../../_env/eks_addons.hcl"
}

inputs = {
  environment = "dev"
}