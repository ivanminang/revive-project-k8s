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
  aws_region              = "us-east-1"
  cluster-autoscaler-sa   = "cluster-autoscaler-sa"
  cluster-autoscaler-ns   = "cluster-autoscaler"
  control_plane_name      = "2024-dev-revive"
  eks-controle-plane-name = "2024-dev-revive"
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

module "cluster-auto-scaler" {
  source                  = "../../../modules/cluster-auto-scaler"
  # aws_region              = local.aws_region
  cluster-autoscaler-sa   = local.cluster-autoscaler-sa
  cluster-autoscaler-ns   = local.cluster-autoscaler-ns
  control_plane_name      = local.control_plane_name
  # eks-controle-plane-name = local.eks-controle-plane-name
  tags                    = local.tags
}
