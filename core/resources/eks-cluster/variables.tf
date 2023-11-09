variable "app_name" {
  description = "Name of application"
  type        = string
  # default     = "karaoke"
}

variable "aws_region" {
  description = "AWS region in which to deploy resources"
  type        = string
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  type        = bool
  # default     = false
}

variable "cluster_enpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled. When it's set to `false` ensure to have a proper private access with `cluster_endpoint_private_access = true`."
  type        = bool
  # default     = true
}

variable "cluster_enpoint_public_access_cidrs" {
  description = "CIDR blocks allowed to have public access to endpoints"
  type        = list(string)
  # default     = []
}

variable "eks_cluster_access_key" {
  description = "Name of SSH key"
  type        = string
  # default     = "karaoke-key-pair"
}

variable "eks_cluster_name" {
  description = "Name of EKS Cluster"
  type        = string
  # default     = "eks-cluster"
}

variable "eks_cluster_public_subnet_ids" {
  description = "Public Subnets in which to place eks nodes"
  type        = list(string)
  # default     = []
}

variable "eks_cluster_service_ipv4_cidr" {
  description = "service ipv4 cidr for the kubernetes cluster"
  type        = string
  # default     = null
}

variable "eks_cluster_version" {
  description = "k8s version of cluster"
  type        = string
  # default     = "1.28"
}

variable "eks_eni_subnet_ids" {
  description = "Subnets for EKS Elastic Network Interfaces"
  type        = list(string)
  # default     = []
}

variable "eks_node_group_name" {
  description = "Name of EKS cluster's node group"
  type        = string
  # default     = "value"
}

variable "eks_oidc_ca_thumbprint" {
  description = "OIDC Thumbprint for EKS cluster OIDC"
  type        = string
}

variable "environment" {
  description = "Name of environment: dev, test, uat or prod"
  type        = string
  # default     = "dev"
}

