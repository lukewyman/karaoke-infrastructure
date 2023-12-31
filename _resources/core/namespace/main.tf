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

variable "environment" {
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


# NAMESPACE

resource "kubernetes_namespace_v1" "dev_namespace" {
  metadata {
    name = "${var.app_name}-${var.environment}"
  }
}
