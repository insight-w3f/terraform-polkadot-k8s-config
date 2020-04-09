data "template_file" "prometheus" {
  template = yamlencode(yamldecode(file("${path.module}/prometheus.yaml")))
}

data "aws_route53_zone" "this" {
  count = var.root_domain_name != "" ? 1 : 0
  name  = "${var.root_domain_name}."
}

resource "helm_release" "prometheus" {
  count      = var.prometheus_enabled ? 1 : 0
  name       = "prometheus"
  chart      = "prometheus"
  repository = data.helm_repository.stable.metadata[0].name
  namespace  = "kube-system"

  values = [data.template_file.prometheus.rendered]
}

resource "kubernetes_config_map" "ingress_nginx_ingress_controller" {
  count = local.prometheus_enabled ? 1 : 0

  metadata {
    name = "ingress-nginx-ingress-controller"
  }

  data = {
    force-ssl-redirect = false

    ssl-redirect = false

    use-proxy-protocol = false
  }
}

resource "helm_release" "ingress" {
  name       = "nginx-ingress"
  chart      = "nginx-ingress"
  repository = data.helm_repository.stable.metadata[0].name
  namespace  = "kube-system"

  set {
    name  = "controller.metrics.enabled"
    value = true
  }

  set {
    name  = "controller.stats.enabled"
    value = true
  }

  set {
    name  = "controller.metrics.serviceMonitor.enabled"
    value = true
  }

  set {
    name  = "rbac.create"
    value = true
  }

  set {
    name  = "controller.publishService.enabled"
    value = true
  }
}

// TODO: Move to aws k8s
resource "aws_route53_record" "prom-record" {
  count = var.prometheus_enabled && local.dns_enabled ? 1 : 0

  allow_overwrite = true
  name            = join(".", ["prometheus", var.root_domain_name])
  ttl             = 30
  type            = "CNAME"
  zone_id         = data.aws_route53_zone.this.*.id

  records = [var.elb_host_name]
}

resource "aws_route53_record" "graf-record" {
  count = var.prometheus_enabled && local.dns_enabled ? 1 : 0

  allow_overwrite = true
  name            = join(".", ["grafana", var.root_domain_name])
  ttl             = 30
  type            = "CNAME"
  zone_id         = data.aws_route53_zone.this.*.id

  records = [var.elb_host_name]
}

resource "aws_route53_record" "alertman-record" {
  count = var.prometheus_enabled && local.dns_enabled ? 1 : 0

  allow_overwrite = true
  name            = join(".", ["alertman", var.root_domain_name])
  ttl             = 30
  type            = "CNAME"
  zone_id         = data.aws_route53_zone.this.*.id

  records = [var.elb_host_name]
}