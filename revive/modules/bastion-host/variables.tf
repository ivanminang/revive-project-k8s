# Define string variables
variable "aws_region" {
  type        = string
  description = "AWS region for resources"
  default     = "us-east-1"
}

variable "ec2_instance_ami" {
  type        = string
  description = "AMI ID for the EC2 instance"
  default     = "ami-0fc5d935ebf8bc3bc"
}

variable "key_name" {
  type        = string
  description = "key name of key pair"
  default     = "revive_bastion_keypair"
}

variable "ec2_instance_type" {
  type        = string
  description = "Instance type for the EC2 instance"
  default     = "t2.micro"
}

# variable "vpc_id" {}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
  default     = "vpc-068852590ea4b093b"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the EC2 instance"
  default     = "subnet-096d45c28d9fb4c14"
}

variable "root_volume_size" {
  type        = number
  description = "Size of the root volume for the EC2 instance"
  default     = 10
}

variable "instance_count" {
  type    = number
  default = 1
}

variable "instance_name" {
  type    = string
  default = "bastion-host"
}

variable "sg_name" {
  type    = string
  default = "bastion-sg"
}

variable "ec2_instance_key_name" {
  type    = string
  default = "terraform-aws"
}

variable "enable_termination_protection" {
  type    = bool
  default = false
}

variable "allowed_ports" {
  description = "List of allowed ports"
  type        = list(number)
  default = [
    22,
    80,
    8080
  ]
}

variable "tags" {
  type = map(any)
  default = {
    "id"             = "2024"
    "owner"          = "Devops Easy Learning"
    "teams"          = "Phase-10-1"
    "environment"    = "Prod"
    "project"        = "revive"
    "create_by"      = "EK-TECH Solutions"
    "cloud_provider" = "aws"
  }
}

