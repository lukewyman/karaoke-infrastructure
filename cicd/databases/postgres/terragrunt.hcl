include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "github.com/lukewyman/karaoke-resources.git//databases/statefulsets/postgres?ref=main"
}

include "postgres" {
  path = "${get_terragrunt_dir()}/../../../_env/postgres.hcl"
}

inputs = {
  environment = "cicd"
}