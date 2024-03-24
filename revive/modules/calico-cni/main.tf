resource "helm_release" "calico" {
  name             = "calico"
  repository       = "https://projectcalico.docs.tigera.io/charts"
  chart            = "tigera-operator"
  namespace        = "tigera-operator"
  create_namespace = true

  set {
    name  = "kubernetesProvider"
    value = "EKS"
  }

  set {
    name  = "controller.serviceAccount.create"
    value = "true"
  }
  set {
    name  = "vpcId"
    value = data.aws_vpc.revive_vpc.id
  }
  set {
    name  = "clusterName"
    value = data.aws_eks_cluster.revive.name
  }

}