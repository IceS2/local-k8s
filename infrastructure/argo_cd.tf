resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.argocd_namespace
  }

  depends_on = [kind_cluster.default]
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = var.argocd_namespace
  version    = var.argocd_helm_version

  values = [file("argocd_values.yaml")]

  depends_on = [kubernetes_namespace.argocd]
}
