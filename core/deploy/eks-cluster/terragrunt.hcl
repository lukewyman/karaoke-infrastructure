include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/../resources/eks-cluster"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    public_subnets = ["mock_subnet_1", "mock_subnet_2"]
  }
}

inputs = {
  app_name                            = "karaoke"
  aws_region                          = "us-east-1"
  cluster_endpoint_private_access     = false
  cluster_enpoint_public_access       = true
  cluster_enpoint_public_access_cidrs = ["0.0.0.0/0"]
  eks_cluster_access_key              = "karaoke-key-pair"
  eks_cluster_name                    = "eks-cluster"
  eks_cluster_public_subnet_ids       = dependency.vpc.outputs.public_subnets
  eks_cluster_service_ipv4_cidr       = "172.20.0.0/16"
  eks_cluster_version                 = "1.28"
  eks_eni_subnet_ids                  = dependency.vpc.outputs.public_subnets
  eks_node_group_name                 = "eks-node-group"
  eks_oidc_ca_thumbprint              = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"
  environment                         = "shared"
}