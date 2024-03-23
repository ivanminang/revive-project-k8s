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
  aws_region             = "us-east-1"
  control_plane_name = "2024-dev-revive"
  cluster_name = "2024-dev-revive"

  # private_subnets = {
  #   us-east-1a = "subnet-096d45c28d9fb4c14"
  #   us-east-1b = "subnet-05f285a35173783b0"
  #   us-east-1c = "subnet-0fe3255479ad7c3a4"
  # }

  private_subnets = {
    us-east-1a = "subnet-0cc5a15f888e1f29a"
    us-east-1b = "subnet-02149dd198eea9b62"
    us-east-1c = "subnet-040ca6eb4cf9e3977"
  }

  eks_version  = "1.24"
  node_min     = "4"
  desired_node = "4"
  node_max     = "6"

  blue_node_color  = "blue"
  green_node_color = "green"

  blue  = false
  green = true

  ec2_ssh_key               = "revive_bastion_keypair"
  deployment_nodegroup      = "blue_green"
  capacity_type             = "ON_DEMAND"
  ami_type                  = "AL2_x86_64"
  instance_types            = "t3.medium"
  disk_size                 = "10"
  shared_owned              = "shared"
  enable_cluster_autoscaler = "true"

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

module "eks-blue-green-node-group" {
  source                    = "../../../modules/eks-blue-green-node-group"
  aws_region                    = local.aws_region
  control_plane_name        = local.control_plane_name
  cluster_name              = local.cluster_name
  eks_version               = local.eks_version
  private_subnets           = values(local.private_subnets)
  node_min                  = local.node_min
  desired_node              = local.desired_node
  node_max                  = local.node_max
  blue_node_color           = local.blue_node_color
  green_node_color          = local.green_node_color
  blue                      = local.blue
  green                     = local.green
  ec2_ssh_key               = local.ec2_ssh_key
  deployment_nodegroup      = local.deployment_nodegroup
  capacity_type             = local.capacity_type
  ami_type                  = local.ami_type
  instance_types            = local.instance_types
  disk_size                 = local.disk_size
  shared_owned              = local.shared_owned
  enable_cluster_autoscaler = local.enable_cluster_autoscaler
  tags                      = local.tags
}
