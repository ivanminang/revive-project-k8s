provider "aws" {
  region = local.aws_region
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
  aws_region                      = "us-east-1"
  aws-load-balancer-controller-sa = "aws-load-balancer-controller-sa"
  aws-load-balancer-controller-ns = "kube-system"
  eks-controle-plane-name         = "2024-prod-revive"
  control_plane_name              = "2024-prod-revive"
  vpc_id                          = "vpc-03af561c239a6fbf5"   # Make sure to put the right vpc id
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

module "aws-load-balancer-controller" {
  source                          = "../../../modules/aws-load-balancer-controller"

  # aws_region                      = local.aws_region
  aws-load-balancer-controller-sa = local.aws-load-balancer-controller-sa
  aws-load-balancer-controller-ns = local.aws-load-balancer-controller-ns
  control_plane_name              = local.control_plane_name
  # eks-controle-plane-name         = local.eks-controle-plane-name
  vpc_id                          = local.vpc_id
  tags                            = local.tags
}
