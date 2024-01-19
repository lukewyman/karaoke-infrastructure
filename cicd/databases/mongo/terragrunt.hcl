include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "github.com/lukewyman/karaoke-resources.git//databases/statefulsets/mongodb?ref=main"
}

include "mongo" {
  path = "${get_terragrunt_dir()}/../../../_env/mongo.hcl"
}

inputs = {
  environment = "cicd"
}

skip = false 