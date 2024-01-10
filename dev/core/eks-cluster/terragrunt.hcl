include "root" {
  path = find_in_parent_folders()
}

include "eks_cluster" {
  path = "${get_terragrunt_dir()}/../../../_env/eks_cluster.hcl"
}

inputs = {
  cluster_desired_size = 2
  cluster_max_size = 3
  cluster_min_size = 1
  environment = "dev"
}