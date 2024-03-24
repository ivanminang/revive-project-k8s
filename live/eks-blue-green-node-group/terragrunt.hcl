terraform {
  # Deploy version v0.0.3 in stage
  source = "https://github.com/ivanminang/revive-project-k8s.git//revive-parent-module-github/modules/eks-blue-green-node-group?ref=v0.0.1"
}

dependencies {
  paths = ["../vpc-revive", "../ eks-control-plane"]
}