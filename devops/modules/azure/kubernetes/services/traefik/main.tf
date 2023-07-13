# Traefik Deployment

resource "kubernetes_namespace" "traefik" {
  metadata {
    name = "traefik"
  }
}

resource "helm_release" "traefik" {
  depends_on = [
    kubernetes_namespace.traefik
  ]

  name      = "traefik"
  namespace = "traefik"

  repository = "https://helm.traefik.io/traefik"
  chart      = "traefik"

  # Set Ingress Class
  set {
    name  = "ingressClass.enable"
    value = "true"
  }
  set {
    name  = "ingressClass.isDefaultClass"
    value = "true"
  }

  # Set Redirect from HTTP to HTTPS
  set {
    name  = "ports.web.redirectTo"
    value = "websecure"
  }
  set {
    name  = "ports.websecure.tls.enabled"
    value = "true"
  }

}

resource "time_sleep" "wait_for_traefik" {
  depends_on      = [helm_release.traefik]
  create_duration = "10s"
}
