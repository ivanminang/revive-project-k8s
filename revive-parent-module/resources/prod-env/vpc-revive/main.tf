provider "aws" {
  region = local.region
}

terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# terraform {
#   backend "s3" {
#     bucket            = "revive-project"                      # Name of the s3 bucket
#     dynamodb_table    = "revive-tfstate-locking-table"        # Name of the dynamodb table
#     key               = "prod/terraform.tfstate"              # path to the tfstate file (terraform.tfstate is under the prod folder in the revive-project bucket )
#     region            = "us-east-1"
#   }
# }

locals {
  region       = "us-east-1"
  cluster_name = "2024-prod-revive"
  cidr_block   = "10.0.10.0/16"
  # cidr_block = "10.10.0.0/16"
  availability_zones = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]

  tags = {
    "id"             = "2024"
    "owner"          = "Devops Easy Learning"
    "teams"          = "Phase-10-1"
    "environment"    = "prod"
    "project"        = "revive"
    "create_by"      = "EK-TECH Solutions"
    "cloud_provider" = "aws"
  }
}

module "vpc-revive" {
  source = "../../../modules/vpc-revive"
  # source = "git::ssh://git@github.com/devopstia/terraform-course-del.git//aws-terraform/modules/vpc-01?ref=main"
  cidr_block         = local.cidr_block
  region             = local.region
  availability_zones = local.availability_zones
  cluster_name       = local.cluster_name
  tags               = local.tags
}
