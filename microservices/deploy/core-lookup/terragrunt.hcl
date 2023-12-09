include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/../../lookups/core"
}

inputs = {
  environment          = "shared"
  vpc_workspace_prefix = "karaoke-vpc"
  eks_workspace_prefix = "karaoke-eks-cluster"
}