resource "kubernetes_namespace" "certmanager" {
  metadata {
    name = "certmanager"
  }
  depends_on = [
    time_sleep.wait_for_traefik
  ]
}

resource "helm_release" "certmanager" {
  depends_on = [
    kubernetes_namespace.certmanager
  ]

  name      = "certmanager"
  namespace = "certmanager"

  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"

  set {
    name  = "installCRDs"
    value = "true"
  }
}

resource "time_sleep" "wait_for_certmanager" {
  depends_on = [
    helm_release.certmanager
  ]
  create_duration = "10s"
}
