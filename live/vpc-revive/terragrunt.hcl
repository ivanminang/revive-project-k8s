

terraform {
  # Deploy version v0.0.3 in stage
  source = "github.com/ivanminang/revive-project-k8s.git//revive-parent-module-github/modules/vpc-revive?ref=v0.0.1"
  # source = "git::https://github.com/ivanminang/revive-project-k8s.git//revive-parent-module-github/modules/vpc-revive?ref=v0.0.1"
}
