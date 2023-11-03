variable "context" {
  description = "Database context. Acceptable values: 'AWS-MANAGED', 'AWS-MANAGED"
  validation {
    condition = contains(["AWS-MANAGED", "STATEFULSET"], upper(var.context))
    error_message = "Invalid value for context. Only 'AWS-MANAGED' or 'STATEFULSET' are allowed."
  }
  default = "AWS-MANAGED"
}

variable "environment" {
  description = "Environment of Terraform project"
  default = ""
}