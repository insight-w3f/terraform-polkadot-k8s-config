resource "kubernetes_service" "api_proxy" {
  metadata {
    name = "api-proxy"
  }
  spec {
    type          = "ExternalName"
    external_name = var.lb_endpoint
  }
}

resource "kubernetes_ingress" "api_proxy" {
  metadata {
    name = "api-proxy-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      host = "api.${var.region}.${var.cloud_platform}.polkadot.${var.root_domain_name}"
      http {
        path {
          backend {
            service_name = "api-proxy"
            service_port = 9933
          }
          path = "/v0"
        }
      }
    }
  }
}