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

variable "cluster_certificate_authority_data" {
  description = ""
  type = string 
}

variable "db_port" {
  description = "Database connection port"
  type        = string
}

variable "eks_cluster_id" {
  description = ""
  type = string 
}

variable "environment" {
  description = "Name of environment: dev, test, uat or prod"
  type        = string
}

variable "migrations_dir" {
  description = "Directory for migration .sql files"
  type = string 
}

variable "postgres_user" {    
  description = ""
  type = string
}