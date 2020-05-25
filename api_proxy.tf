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
  count = var.cert_manager_enabled ? 0 : 1
  metadata {
    name = "api-proxy-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      host = "api.${var.deployment_domain_name}"
      http {
        path {
          backend {
            service_name = "api-proxy"
            service_port = 9933
          }
          path = "/v0"
        }
        path {
          backend {
            service_name = "api-proxy"
            service_port = 9944
          }
          path = "/"
        }
      }
    }
  }
}

resource "kubernetes_ingress" "api_proxy_ssl" {
  count = var.cert_manager_enabled ? 1 : 0
  metadata {
    name = "api-proxy-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
      "cert-manager.io/cluster-issuer" : var.issuer_name
    }
  }
  spec {
    tls {
      hosts       = ["api.${var.deployment_domain_name}"]
      secret_name = "api-ingress-tls"
    }
    rule {
      host = "api.${var.deployment_domain_name}"
      http {
        path {
          backend {
            service_name = "api-proxy"
            service_port = 9933
          }
          path = "/v0"
        }
        path {
          backend {
            service_name = "api-proxy"
            service_port = 9944
          }
          path = "/"
        }
      }
    }
  }
}