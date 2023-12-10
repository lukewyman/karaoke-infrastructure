include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/../../../lookups/databases"
}

inputs = {
  environment = "dev"
  mongo_workspace_prefix = "karaoke-docdb"
  postgres_workspace_prefix = "karaoke-postgres"
}