terraform {
  required_version = ">= 1.6.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.23"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.24"
    }
  }

  backend "remote" {
    organization = "spikes"

    workspaces {
      prefix = "karaoke-namespaces-"
    }
  }
}

variable "app_name" {
  type = string 
}

variable "aws_region" {
 type = string 
}

variable "cluster_certificate_authority_data" {
  type = string 
}

variable "eks_cluster_endpoint" {
  type = string 
}

variable "eks_cluster_id" {
  type = string 
}

provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  host                   = var.eks_cluster_endpoint
  cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster_auth.token
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.eks_cluster_id
}


# NAMESPACES

resource "kubernetes_namespace_v1" "dev_namespace" {
  metadata {
    name = "${var.app_name}-dev"
  }
}

resource "kubernetes_namespace_v1" "test_namespace" {
  metadata {
    name = "${var.app_name}-test"
  }
}