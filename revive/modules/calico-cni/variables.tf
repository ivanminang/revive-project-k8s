variable "aws_region" {
  type        = string
  description = "AWS region for resources"
  default     = "us-east-1"
}

variable "control_plane_name" {
  type    = string
  default = "2024-prod-revive"
}

variable "vpc_id" {
  type    = string
  default = "vpc-068852590ea4b093b"
}