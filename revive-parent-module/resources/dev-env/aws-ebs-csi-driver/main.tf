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
  aws-ebs-csi-driver-sa   = "aws-ebs-csi-driver-sa"
  aws-ebs-csi-driver-ns   = "aws-ebs-csi-driver"
  eks-controle-plane-name = "2024-dev-revive"
  control_plane_name      = "2024-dev-revive"
  storage-class-name      = "2024-dev-revive"
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

module "aws-ebs-csi-driver" {
  source                  = "../../../modules/aws-ebs-csi-driver"
  # aws_region              = local.aws_region
  aws-ebs-csi-driver-sa   = local.aws-ebs-csi-driver-sa
  aws-ebs-csi-driver-ns   = local.aws-ebs-csi-driver-ns
  control_plane_name              = local.control_plane_name
  # eks-controle-plane-name = local.eks-controle-plane-name
  storage-class-name      = local.storage-class-name
  tags                    = local.tags
}
