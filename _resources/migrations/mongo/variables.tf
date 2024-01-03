variable "app_name" {
  description = ""
  type        = string
}

variable "app_user" {
  description = ""
  type        = string
}

variable "aws_region" {
  description = ""
  type        = string
}

variable "aws_iam_openid_connect_provider_arn" {
  description = ""
  type        = string
}

variable "cluster_certificate_authority_data" {
  description = ""
  type        = string
}

variable "eks_cluster_endpoint" {
  description = ""
  type        = string
}

variable "eks_cluster_id" {
  description = ""
  type        = string
}

variable "environment" {
  description = ""
  type        = string
}

variable "migrations_dir" {
  description = ""
  type        = string
}

variable "db_port" {
  description = ""
  type        = string
}

variable "service_account_name" {
  description = ""
  type        = string
}