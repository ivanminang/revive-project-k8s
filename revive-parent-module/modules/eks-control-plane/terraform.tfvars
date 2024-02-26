region                  = "us-east-1"
cluster_name            = "2024-prod-revive"
eks_version             = 1.24
endpoint_private_access = false
endpoint_public_access  = true
tags = {
  "id"             = "2024"
  "owner"          = "Devops Easy Learning"
  "teams"          = "Phase-10-1"
  "environment"    = "Prod"
  "project"        = "revive"
  "create_by"      = "EK-TECH Solutions"
  "cloud_provider" = "aws"
}

# public_subnets = {
#   us-east-1a = "subnet-096d45c28d9fb4c14"
#   us-east-1b = "subnet-05f285a35173783b0"
#   us-east-1c = "subnet-0fe3255479ad7c3a4"
# }
