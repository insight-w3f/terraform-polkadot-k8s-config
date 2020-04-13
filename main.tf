
locals {
  prometheus_enabled    = var.all_enabled ? true : var.prometheus_enabled
  consul_enabled        = var.all_enabled ? true : var.consul_enabled
  elasticsearch_enabled = var.all_enabled ? true : var.elasticsearch_enabled
  nginx_ingress_enabled = var.all_enabled ? true : var.nginx_ingress_enabled
  external_dns_enabled  = var.all_enabled ? true : var.external_dns_enabled
}

data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}

data "helm_repository" "bitnami" {
  name = "bitnami"
  url  = "https://charts.bitnami.com/bitnami"
}