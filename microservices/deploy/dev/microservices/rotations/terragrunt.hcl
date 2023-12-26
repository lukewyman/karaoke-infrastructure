include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/../../../resources/microservice"
}

dependency "core_lookup" {
  config_path = "../../../core-lookup"

  mock_outputs = {
    aws_iam_openid_connect_provider_arn = "mock_oicd_arn"
    cluster_certificate_authority_data  = "bW9ja19jZXJ0X2F1dGhfZGF0YQ=="
    eks_cluster_endpoint                = "mock_cluster_endpoint"
    eks_cluster_id                      = "mock_cluster_id"
  }
}

inputs = {
  app_name                            = "karaoke"
  aws_iam_openid_connect_provider_arn = dependency.core_lookup.outputs.aws_iam_openid_connect_provider_arn
  aws_region                          = "us-east-1"
  cluster_certificate_authority_data  = dependency.core_lookup.outputs.cluster_certificate_authority_data
  container_port                      = 8081
  eks_cluster_endpoint                = dependency.core_lookup.outputs.eks_cluster_endpoint
  eks_cluster_id                      = dependency.core_lookup.outputs.eks_cluster_id
  env = {
    "QUEUES_TABLE_NAME"           = "queues"
    "ENQUEUED_SINGERS_TABLE_NAME" = "enqueued_singers"
    "SONG_CHOICES"                = "song_choices"
  }
  environment = "dev"
  iam_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonDocDBFullAccess"
  ]
  image_repository_name = "karaoke-image-dev-rotations"
  image_version         = "v1"
  namespace_root        = "karaoke"
  node_port             = "31283"
  service_account_name  = ""
  service_name          = "rotations"
}

generate "backend" {
  path = "backend.tf"
  if_exists = "overwrite"
  contents = <<EOF 
terraform {
  required_version = ">= 1.6.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.23"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.24"
    }
  }

  backend "remote" {
    organization = "spikes"

    workspaces {
      prefix = "karaoke-rotations-"
    }
  }
}
  EOF
}