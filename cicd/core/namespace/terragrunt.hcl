include "root" {
  path = find_in_parent_folders()
}

include "namespace" {
  path = "${get_terragrunt_dir()}/../../../_env/namespace.hcl"
}

inputs = {
  environment = "cicd"
}