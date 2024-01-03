include "root" {
  path = find_in_parent_folders()
}

include "eks_cluster" {
  path = "${get_terragrunt_dir()}/../../../_env/eks_cluster.hcl"
}

inputs = {
  environment = "dev"
}