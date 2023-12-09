variable "aws_region" {
  description = ""
  type        = string
  default     = "us-east-1"
}

variable "cluster_certificate_authority_data" {
  description = ""
  type        = string
}

variable "container_port" {
  description = ""
  type = string 
}

variable "eks_cluster_endpoint" {
  description = ""
  type        = string
}

variable "eks_cluster_id" {
  description = ""
  type        = string
}

variable "image_repository_name" {
  type = string 
}

variable "image_version" {
  type = string 
}

variable "mongo_port" {
  type = string 
}

variable "node_port" {
  type = string 
}

variable "service_name" {
  type = string 
  default = "song-library"
}