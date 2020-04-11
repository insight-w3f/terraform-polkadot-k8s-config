data "template_file" "prometheus" {
  template = yamlencode(yamldecode(file("${path.module}/prometheus.yaml")))
  vars = {
    region                 = var.region
    cloud_platform         = var.cloud_platform
    slack_api_key          = var.slack_api_key
    alertmanager_subdomain = var.alertmanager_subdomain
    grafana_subdomain      = var.grafana_subdomain
    prometheus_subdomain   = var.prometheus_subdomain
    root_domain_name       = var.root_domain_name
  }
}



resource "helm_release" "prometheus" {
  count      = var.prometheus_enabled ? 1 : 0
  name       = "prometheus"
  chart      = "stable/prometheus"
  repository = data.helm_repository.stable.metadata[0].name
  namespace  = "kube-system"

  values = [data.template_file.prometheus.rendered]
}

