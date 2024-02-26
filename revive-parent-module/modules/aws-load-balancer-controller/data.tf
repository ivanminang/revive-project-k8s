data "aws_eks_cluster" "revive" {

  # name = "2024-prod-revive"
  name = var.control_plane_name
}

data "aws_eks_cluster_auth" "revive" {
  # name = "2024-prod-revive"
  name = var.control_plane_name
}

# Get AWS Account ID
data "aws_caller_identity" "current" {}
