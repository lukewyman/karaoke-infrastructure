variable "app_name" {
  description = ""
  type        = string
}

variable "aws_iam_openid_connect_provider_arn" {
  description = ""
  type        = string
}

variable "aws_region" {
  description = ""
  type        = string
}

variable "cluster_certificate_authority_data" {
  description = ""
  type        = string
}

variable "container_port" {
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

variable "env" {
  description = ""
  type        = map(string)
  default = {
    "MONGO_ARCHITECTURE" = "replicaset"
    "MONGO_HOSTNAME"     = "mongo"
    "MONGO_PORT"         = "27017"
  }
}

variable "env_parameter_store_text" {
  description = ""
  type        = list(string)
  default = [
    "MONGO_USERNAME"
  ]
}

variable "env_parameter_store_secret" {
  description = ""
  type        = list(string)
  default = [
    "MONGO_PASSWORD"
  ]
}

variable "iam_policy_arns" {
  description = "IAM policies for this micorservice's k8s service account"
  type        = list(string)
  # default = [
  #   "arn:aws:iam::aws:policy/AmazonDocDBFullAccess"
  # ]
}

variable "image_repository_name" {
  description = ""
  type        = string
}

variable "image_version" {
  description = ""
  type        = string
}

variable "mongo_port" {
  description = ""
  type        = string
}

variable "namespace_root" {
  description = ""
  type        = string
}

variable "node_port" {
  description = ""
  type        = string
}

variable "service_name" {
  description = ""
  type        = string
}