include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/_resources/core/eks-cluster"
}

include "eks_cluster" {
  path = "${get_terragrunt_dir()}/../../../_env/eks_cluster.hcl"
}

inputs = {
  environment = "dev"
}