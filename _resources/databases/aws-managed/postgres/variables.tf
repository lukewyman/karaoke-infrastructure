variable "allocated_storage" {
  description = "Allocated disk storage"
  type        = number
}

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

variable "db_engine" {
  description = "The database engine for the RDS instance"
  type        = string
}

variable "db_engine_version" {
  description = "The database engine version for the RDS instance"
  type        = string
}

variable "db_instance_type" {
  description = "The RDS instance type to deploy"
  type        = string
}

variable "db_port" {
  description = "Database connection port"
  type        = string
}

variable "db_storage_type" {
  description = "Disk type for DB storage"
  type        = string
}

variable "db_subnet_ids" {
  description = "Subnet ids for the database subnet group"
  type        = list(string)
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

variable "migrations_dir" {
  description = "Directory for migration .sql files"
  type = string 
}

variable "private_subnets_cidr_blocks" {
  description = "List of CIDR blocks for the private subnets"
  type        = list(string)
}

variable "postgres_app_username" {
  description = ""
  type = string 
}

variable "public_subnets_cidr_blocks" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC id for the Postgress Security Group"
  type        = string
}

