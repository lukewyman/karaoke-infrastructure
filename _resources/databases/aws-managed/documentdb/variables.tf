variable "app_name" {
  description = "Name of application"
  type        = string
}

variable "aws_iam_openid_connect_provider_arn" {
  description = ""
  type = string
}

variable "aws_region" {
  description = "AWS region in which to deploy resources"
  type        = string
}

variable "docdb_engine_version" {
  description = "DocumentDB engine version"
  type        = string
}

variable "docdb_instance_class" {
  description = "DocumentDB RDS instance class"
  type        = string
}

variable "docdb_instance_count" {
  description = "Number of RDS instances for the DocumentDB cluster"
  type        = number
  default     = 1
}

variable "docdb_port" {
  description = "DocumentDB port"
  type        = string
}

variable "docdb_subnet_ids" {
  description = "Subnets for the DocumentDB Subnet Group"
  type        = list(string)
}

variable "docdb_username" {
  description = ""
  type = string
}

variable "cluster_certificate_authority_data" {
  description = ""
  type = string
}

variable "eks_cluster_endpoint" {
  description = ""
  type = string 
}

variable "eks_cluster_id" {
  description = ""
  type = string 
}

variable "environment" {
  description = "Name of environment: dev, test, uat or prod"
  type        = string
}

variable "private_subnets_cidr_blocks" {
  description = "List of CIDR blocks for the private subnets"
  type        = list(string)
}

variable "public_subnets_cidr_blocks" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC id for the DocumentDB cluster and Security Group"
  type        = string
}