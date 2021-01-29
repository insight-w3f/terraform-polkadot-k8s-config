
locals {
  prometheus_enabled    = var.all_enabled ? true : var.prometheus_enabled
  consul_enabled        = var.all_enabled ? true : var.consul_enabled
  elasticsearch_enabled = var.all_enabled ? true : var.elasticsearch_enabled
  nginx_ingress_enabled = var.all_enabled ? true : var.nginx_ingress_enabled
  external_dns_enabled  = var.all_enabled ? true : var.external_dns_enabled
  cert_manager_enabled  = var.all_enabled ? true : var.cert_manager_enabled
}

data "helm_repository" "stable" {
  name = "stable"
  url  = "helm init --stable-repo-url https://charts.helm.sh/stable"
}

data "helm_repository" "bitnami" {
  name = "bitnami"
  url  = "https://charts.bitnami.com/bitnami"
}

data "helm_repository" "jetstack" {
  name = "jetstack"
  url  = "https://charts.jetstack.io"
}