variable "aws_region" {
  description = ""
  type        = string
  default     = "us-east-1"
}

variable "app_name" {
  description = ""
  type        = string
  default     = ""
}

variable "cluster_certificate_authority_data" {
  description = ""
  type        = string
  default     = ""
}

variable "eks_cluster_endpoint" {
  description = ""
  type        = string
  default     = ""
}

variable "eks_cluster_id" {
  description = ""
  type        = string
  default     = ""
}

variable "environment" {
  description = ""
  type        = string
  default     = "dev"
}

variable "aws_iam_openid_connect_provider_arn" {
  description = ""
  type        = string
  default     = ""
}

variable "vpc_id" {
  description = ""
  type        = string
}