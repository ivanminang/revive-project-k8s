variable "tags" {
  type        = map(string)
  description = "Common tags to be applied to resources"
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

variable "region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "eks_version" {
  type = string
}

variable "endpoint_private_access" {
  type = bool
}

variable "endpoint_public_access" {
  type = bool
}

variable "public_subnets" {
  # type = map(any)
  default = {
    us-east-1a = ""
    us-east-1b = ""
    us-east-1c = ""
  }
}

# variable "public_subnet_ids" {
#   description = "A list of subnet IDs where the EKS cluster control plane (ENIs) will be provisioned. 
#   type        = list(string)
#   default     = []
# }

# # variable "public_subnets" {
# # #   type = map(string)
# # #   default = {
# # #     us-east-1a = "subnet-096d45c28d9fb4c14"
# # #     us-east-1b = "subnet-05f285a35173783b0"
# # #     us-east-1c = "subnet-0fe3255479ad7c3a4"
# # #   }
# # # }