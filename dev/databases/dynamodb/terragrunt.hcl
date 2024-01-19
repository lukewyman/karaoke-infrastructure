include "root" {
  path = find_in_parent_folders()
}

include "dynamodb" {
  path = "${get_terragrunt_dir()}/../../../_env/dynamodb.hcl"
}

inputs = {
  environment = "dev"
}

skip = false