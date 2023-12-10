data "terraform_remote_state" "mongo" {
  backend = "remote"

  config = {
    hostname = "app.terraform.io"
    organization = "spikes"

    workspaces = {
      name = "${var.mongo_workspace_prefix}-${var.environment}"
    }
  }
}

# data "terraform_remote_state" "postgres" {
#   backend = "remote"

#   config = {
#     hostname = "app.terraform.io"
#     organization = "spikes"

#     workspaces = {
#       name = "${var.postgres_workspace_prefix}-${var.environment}"
#     }
#   }
# }