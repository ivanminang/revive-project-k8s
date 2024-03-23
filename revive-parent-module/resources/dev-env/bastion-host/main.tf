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
  aws_region                    = "us-east-1"
  ec2_instance_ami              = "ami-0fc5d935ebf8bc3bc"
  ec2_instance_type             = "t2.micro"
  sg_name                       = "bastion-sg"
  instance_name                 = "bastion"
  vpc_id                        = "vpc-03af561c239a6fbf5"
  subnet_id                     = "subnet-0544d1a871497bf29"
  root_volume_size              = 10
  instance_count                = 1
  enable_termination_protection = false
  ec2_instance_key_name         = "revive_bastion_keypair"
  allowed_ports = [
    22
  ]
  tags = {
    "id"             = "2024"
    "owner"          = "Devops Easy Learning"
    "teams"          = "Phase-10-1"
    "environment"    = "Prod"
    "project"        = "revive"
    "create_by"      = "EK-TECH Solutions"
    "cloud_provider" = "aws"
  }
}

module "bastion-host" {
  source                        = "../../../modules/bastion-host"
  aws_region                    = local.aws_region
  ec2_instance_ami              = local.ec2_instance_ami
  ec2_instance_type             = local.ec2_instance_type
  sg_name                       = local.sg_name
  instance_name                 = local.instance_name
  ec2_instance_key_name         = local.ec2_instance_key_name
  vpc_id                        = local.vpc_id
  subnet_id                     = local.subnet_id
  root_volume_size              = local.root_volume_size
  instance_count                = local.instance_count
  allowed_ports                 = local.allowed_ports
  enable_termination_protection = local.enable_termination_protection
  tags                          = local.tags
}
