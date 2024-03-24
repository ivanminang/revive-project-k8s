terraform {
  # Deploy version v0.0.3 in stage
  source = "https://github.com/ivanminang/revive-project-k8s.git//revive-parent-module-github/modules/aws-auth-config?ref=v0.0.1"
}

dependencies {
  paths = ["../vpc-revive", "../eks-blue-green-node-group", "../ eks-control-plane"]
}