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
#     bucket         = ""
#     dynamodb_table = ""
#     key            = ""
#     region         = ""
#   }
# }

locals {
  region                  = "us-east-1"
  cluster_name            = "2024-dev-revive"
  eks_version             = 1.24
  endpoint_private_access = false
  endpoint_public_access  = true


  public_subnets = {
    us-east-1a = "subnet-0544d1a871497bf29"
    us-east-1b = "subnet-0591e3a84c68fd56a"
    us-east-1c = "subnet-073b88dc26dd53e17"
  }


  tags = {
    "id"             = "2024"
    "owner"          = "Devops Easy Learning"
    "teams"          = "Phase-10-1"
    "environment"    = "dev"
    "project"        = "revive"
    "create_by"      = "EK-TECH Solutions"
    "cloud_provider" = "aws"
  }
}

module "eks-control-plane" {
  source                  = "../../../modules/eks-control-plane"
  region                  = local.region
  cluster_name            = local.cluster_name
  eks_version             = local.eks_version
  endpoint_private_access = local.endpoint_private_access
  endpoint_public_access  = local.endpoint_public_access
  # public_subnets          = local.subnet_ids
  public_subnets          = values(local.public_subnets)
  # subnet_ids              = local.subnet_ids
  tags                    = local.tags
}
