
provider "aws" {
  region = local.aws_region
}

# terraform {
#   required_version = ">= 1.0.0"
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "~> 4.0"
#     }
#   }
# }

# terraform {
#   backend "s3" {
#     bucket         = ""
#     dynamodb_table = ""
#     key            = ""
#     region         = ""
#   }
# }

locals {
  aws_region                = "us-east-1"
}
module "ssl-certificate" {
  source                  = "../../../modules/ssl-certificate"
}
