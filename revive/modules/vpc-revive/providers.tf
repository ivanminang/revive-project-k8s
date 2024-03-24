terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  # region = "us-east-1" # Change to your desired AWS region
  region = var.region
}

# terraform {
#   backend "s3" {
#     bucket         = "revive-project"
#     dynamodb_table = "revive-tfstate-locking-table"
#     key            = "dev/vpc/terraform.tf"
#     region         = "us-east-1"
#   }
# }
