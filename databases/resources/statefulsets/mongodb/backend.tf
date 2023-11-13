terraform {
  required_version = ">= 1.6.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }

  backend "remote" {
    organization = "spikes"

    workspaces {
      prefix = "karaoke-mongodb-"
    }
  }
}