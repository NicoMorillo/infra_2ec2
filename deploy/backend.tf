terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = ""
    key    = "infra/deploy/terraform.state"
    region = "us-east-1"
    acl    = "bucket-owner-full-control"
    dynamodb_table = "infra-dynamo"

  }
}