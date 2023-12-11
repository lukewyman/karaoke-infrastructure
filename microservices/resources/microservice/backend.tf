terraform {
  required_version = ">= 1.6.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.23"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.24"
    }
  }

  backend "remote" {
    organization = "spikes"

    workspaces {
      prefix = "karaoke-song-library-"
    }
  }
}