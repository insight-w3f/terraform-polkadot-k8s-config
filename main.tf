
locals {
  prometheus_enabled    = var.all_enabled ? true : var.prometheus_enabled
  consul_enabled        = var.all_enabled ? true : var.consul_enabled
  elasticsearch_enabled = var.all_enabled ? true : var.elasticsearch_enabled

  dns_enabled = var.root_domain_name != "" ? true : false
}

data "helm_repository" "stable" {
  name = "stable"
  url  = "https://kubernetes-charts.storage.googleapis.com"
}
