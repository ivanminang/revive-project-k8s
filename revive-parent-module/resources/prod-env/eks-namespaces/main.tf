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
  control_plane_name = "2024-prod-revive"
  aws_region         = "us-east-1"
  name_spaces = [
    "aws-ebs-csi-driver",
    "aws-efs-csi-driver",
    "cluster-autoscaler",
    "external-dns",
    "metrics-server",
    "app",
    "datadog",
    "monitoring",
    "argocd",
    "security",
    "jenkins",
    "argo-cd",
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

module "eks-namespaces" {
  source             = "../../../modules/eks-namespaces"
  # aws_region         = local.aws_region
  control_plane_name = local.control_plane_name
  name_spaces        = local.name_spaces
  tags               = local.tags
}
