include "root" {
  path = find_in_parent_folders()
}

include "eks_addons" {
  path = "${get_terragrunt_dir()}/../../../_env/eks_addons.hcl"
}

inputs = {
  environment = "cicd"
}