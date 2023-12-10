variable "environment" {
  description = "Environment of Terraform project"
  type = string 
  default = "dev"
}

variable "mongo_workspace_prefix" {
  description = "Workspace prefix for the Mongo project."
  type = string 
  default = "karaoke-docdb"
}

variable "postgres_workspace_prefix" {
  description = "Workspace prefix for the Postgres project"
  default = "karaoke-postgres"
}