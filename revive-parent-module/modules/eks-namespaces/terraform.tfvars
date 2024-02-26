control_plane_name = "2024-prod-revive"
region         = "us-east-1"
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

tags = {
  "id"             = "2024"
    "owner"          = "Devops Easy Learning"
    "teams"          = "Phase-10-1"
    "environment"    = "Prod"
    "project"        = "revive"
    "create_by"      = "EK-TECH Solutions"
    "cloud_provider" = "aws"
}
