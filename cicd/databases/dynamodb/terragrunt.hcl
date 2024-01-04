include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "${get_parent_terragrunt_dir("root")}/_resources/databases/serverless/dynamodb"
}

inputs = {
  app_name    = "karaoke"
  aws_region  = "us-east-1"
  environment = "cicd"
  table_names = {
    "queues" = {
      "attributes" = {
        "queue_id" = "S"
      }
      "keys" = {
        "hash_key" = "queue_id"
      }
    }
    "enqueued-singers" = {
      "attributes" = {
        "queue_id"       = "S",
        "queue_position" = "N"
      }
      "keys" = {
        "hash_key"  = "queue_id",
        "range_key" = "queue_position"
      }
    }
    "song-choices" = {
      "attributes" = {
        "enqueued_singer_id" = "S",
        "position"           = "N"
      }
      "keys" = {
        "hash_key"  = "enqueued_singer_id",
        "range_key" = "position"
      }
    }
  }
}

skip = false