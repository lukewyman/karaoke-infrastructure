variable "app_name" {
  description = "Name of application"
  type        = string
}

variable "aws_region" {
  description = "AWS region in which to deploy resources"
  type        = string
}

variable "environment" {
  description = "Name of environment: dev, test, uat or prod"
  type        = string
}

variable "instance_keypair" {
  description = "Keypair to SSH into the bastion host"
  type        = string
}

variable "instance_type" {
  description = "Instance type for bastion host"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet in which to place bastion host"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC id for bastion security group"
  type        = string
}