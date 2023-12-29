locals {
  versions = read_terragrunt_config(find_in_parent_folders("_common/provider_versions.hcl"))
}

generate = local.versions.generate

remote_state {
  backend = "s3"

  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }

  config = {
    bucket               = "karaoke-infrastructure-state"
    key                  = "${path_relative_to_include("root")}/terraform.tfstate"
    encrypt              = true
    dynamodb_table       = "karaoke-infrastructure-state"
    region               = "us-east-1"
    workspace_key_prefix = "karaoke"
  }
}