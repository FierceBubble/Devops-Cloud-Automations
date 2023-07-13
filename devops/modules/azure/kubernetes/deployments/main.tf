resource "kubernetes_namespace" "namespace" {
  metadata {
    name = var.app_name
  }
}

resource "kubernetes_deployment" "deployment" {
  depends_on = [kubernetes_namespace.namespace]
  metadata {
    name      = var.app_name
    namespace = var.app_name
    labels = {
      app = var.app_name
    }
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = var.app_name
      }
    }

    template {
      metadata {
        labels = {
          app = var.app_name
        }
      }

      spec {
        container {
          image = var.container_image
          name  = var.app_name
          port {
            container_port = var.container_port
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "service" {
  depends_on = [kubernetes_deployment.deployment]
  metadata {
    name      = var.app_name
    namespace = var.app_name
  }
  spec {
    selector = {
      app = var.app_name
    }
    port {
      protocol    = "TCP"
      port        = var.container_port
      target_port = var.container_port
    }
    type             = var.container_type
    load_balancer_ip = "20.24.78.252"
  }
}
