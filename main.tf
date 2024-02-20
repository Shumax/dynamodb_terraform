terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  shared_credentials_files = ["$HOME/.aws/credentials"]
}

resource "aws_dynamodb_table" "tf_notes_table" {
  name = "tf-notes-table"
  billing_mode = "PROVISIONED"
  read_capacity = "1"
  write_capacity = "1"
  hash_key = "noteId"
  
  attribute {
    name = "noteId"
    type = "S"
  }

  // Time to live
  ttl {
    enabled = true
    // the attribute name which enforces  TTL, must be a Number      (Timestamp)
    attribute_name = 7200
  }

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }

}

# module "table_autoscaling" {
#   source = "snowplow-devops/dynamodb-autoscaling/aws" // add the autoscaling module
#   table_name = aws_dynamodb_table.tf_notes_table.name // apply autoscaling for the tf_notes_table
# }
