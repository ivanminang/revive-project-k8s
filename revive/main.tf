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
terraform {
  backend "s3" {
    bucket            = "revive-project"                      # Name of the s3 bucket
    dynamodb_table    = "revive-tfstate-locking-table"        # Name of the dynamodb table
    key               = "prod/terraform.tfstate"              # path to the tfstate file (terraform.tfstate is under the prod folder in the revive-project bucket )
    region            = "us-east-1"
  }
}

locals {
  region                  = "us-east-1"
  azs                     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  cidr_block              = "10.0.0.0/16"
  cluster_name            = "2024-prod-revive"
  control_plane_name       = "2024-prod-revive"
  eks_version             = 1.24
  instance_types          = "t3.medium" # (2vCPU and 4GiB Memory)
  endpoint_private_access = false
  endpoint_public_access  = true
  cluster-autoscaler-sa   = "cluster-autoscaler-sa"
  cluster-autoscaler-ns   = "cluster-autoscaler"
  aws-ebs-csi-driver-sa   = "aws-ebs-csi-driver-sa"
  aws-ebs-csi-driver-ns   = "aws-ebs-csi-driver"
  storage-class-name      = "2024-prod-revive"
  external-dns-sa         = "external-dns-sa"
  external-dns-ns         = "external-dns"
  aws-load-balancer-controller-sa = "aws-load-balancer-controller-sa"
  aws-load-balancer-controller-ns = "kube-system"
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
]
}

module "vpc-revive" {
  source                       = "./modules/vpc-revive"
  cidr_block                   = local.cidr_block
  region                       = local.region
  availability_zones           = local.azs
}

module "bastion-host" {
  source                        = "./modules/bastion-host"
  vpc_id                        = module.vpc-revive.vpc_id
  subnet_id                     = module.vpc-revive.public_subnets[0]
}

module "eks-control-plane" {
  source                  = "./modules/eks-control-plane"
  region                  = local.region
  cluster_name            = local.cluster_name
  eks_version             = local.eks_version
  endpoint_private_access = local.endpoint_private_access
  endpoint_public_access  = local.endpoint_public_access
  public_subnets          = module.vpc-revive.public_subnets
}

module "eks-blue-green-node-group" {
  source                  = "./modules/eks-blue-green-node-group"
  private_subnets         = module.vpc-revive.private_subnets
  node_min                = "4"
  desired_node            = "4"
  node_max                = "6"
  blue                    = false
  green                   = true
  instance_types          = local.instance_types
  cluster_name            = module.eks-control-plane.cluster_name
  eks_version             = local.eks_version
}

module "aws-auth-config" {
  source                        = "./modules/aws-auth-config"
}

module "eks-namespaces" {
  source             = "./modules/eks-namespaces"
  region             = local.region
  # control_plane_name = local.control_plane_name
  control_plane_name = module.eks-control-plane.endpoint
  name_spaces        = local.name_spaces
}

module "cluster-auto-scaler" {
  source                  = "./modules/cluster-auto-scaler"
  region                  = local.region
  cluster-autoscaler-sa   = local.cluster-autoscaler-sa
  cluster-autoscaler-ns   = local.cluster-autoscaler-ns
  # control_plane_name      = local.control_plane_name
  control_plane_name      = module.eks-control-plane.endpoint
}

module "aws-ebs-csi-driver" {
  source                  = "./modules/aws-ebs-csi-driver"
  region                  = local.region
  aws-ebs-csi-driver-sa   = local.aws-ebs-csi-driver-sa
  aws-ebs-csi-driver-ns   = local.aws-ebs-csi-driver-ns
  # control_plane_name      = local.control_plane_name
  control_plane_name      = module.eks-control-plane.endpoint
  storage-class-name      = local.storage-class-name
}

module "aws-load-balancer-controller" {
  source                          = "./modules/aws-load-balancer-controller"
  region                          = local.region
  aws-load-balancer-controller-sa = local.aws-load-balancer-controller-sa
  aws-load-balancer-controller-ns = local.aws-load-balancer-controller-ns
  # control_plane_name              = local.control_plane_name
  control_plane_name              = module.eks-control-plane.endpoint
  vpc_id                          = module.vpc-revive.vpc_id
}

module "external-dns" {
  source                  = "./modules/external-dns"
  region                  = local.region
  external-dns-sa         = local.external-dns-sa
  external-dns-ns         = local.external-dns-ns
  control_plane_name              = module.eks-control-plane.endpoint
  # control_plane_name      = local.control_plane_name
}

module "ssl-certificate" {
  source                  = "./modules/ssl-certificate"

}

