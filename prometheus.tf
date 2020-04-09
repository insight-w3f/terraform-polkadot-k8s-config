data "template_file" "prometheus" {
  template = yamlencode(yamldecode(file("${path.module}/prometheus.yaml")))
}



resource "helm_release" "prometheus" {
  count      = var.prometheus_enabled ? 1 : 0
  name       = "prometheus"
  chart      = "prometheus"
  repository = data.helm_repository.stable.metadata[0].name
  namespace  = "kube-system"

  values = [data.template_file.prometheus.rendered]
}

