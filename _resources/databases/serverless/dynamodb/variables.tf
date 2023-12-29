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

variable "table_names" {
  type = map(map(map(string)))
  # default = {
  #   "queues" = {
  #     "attributes" = {
  #       "queue_id" = "S"
  #     }
  #     "keys" = {
  #       "hash_key" = "queue_id"
  #     }
  #   }
  #   "enqueued-singers" = {
  #     "attributes" = {
  #       "queue_id" = "S",
  #       "queue_position" = "N"
  #     }
  #     "keys" = {
  #       "hash_key" = "queue_id",
  #       "range_key" = "queue_position"
  #     }
  #   }
  #   "song-choices" = {
  #     "attributes" = {
  #       "enqueued_singer_id" = "S",
  #       "position" = "N"
  #     }
  #     "keys" = {
  #       "hash_key" = "enqueued_singer_id",
  #       "range_key" = "position"
  #     }
  #   }
  # }
}