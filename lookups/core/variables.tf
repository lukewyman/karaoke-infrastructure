variable "environment" {
  description = "Environment of Terraform project"
  type = string 
}

variable "vpc_workspace_prefix" {
  description = "Workspace prefix for the VPC project."
  type = string 
}

variable "eks_workspace_prefix" {
  description = "Workspace prefix for the EKS Cluster project"
}