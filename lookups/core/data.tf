data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    hostname = "app.terraform.io"
    organization = "spikes"

    workspaces = {
      name = "${var.vpc_workspace_prefix}-${var.environment}"
    }
  }
}

data "terraform_remote_state" "eks_cluster" {
  backend = "remote"

  config = {
    hostname = "app.terraform.io"
    organization = "spikes"

    workspaces = {
      name = "${var.eks_workspace_prefix}-${var.environment}"
    }
  }
}