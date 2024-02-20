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
  attribute {
    name = "noteId"
    type = "S"
  }
  hash_key = "noteId"
}
