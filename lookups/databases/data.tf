data "terraform_remote_state" "mongo" {
  backend = "remote"

  config = {
    hostname = "app.terraform.io"
    organization = "spikes"

    workspaces = {
      name = "${var.context}-${var.environment}-something, something"
    }
  }
}

data "terraform_remote_state" "postgres" {
  backend = "remote"

  config = {
    hostname = "app.terraform.io"
    organization = "spikes"

    workspaces = {
      name = "${var.context}-${var.environment}-something, something"
    }
  }
}