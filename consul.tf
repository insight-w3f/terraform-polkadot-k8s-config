
data "template_file" "consul" {
  template = yamlencode(yamldecode(file("${path.module}/consul.yaml")))
  vars = {
    region = var.region
  }
}


resource "helm_release" "consul" {
  count = var.consul_enabled ? 1 : 0
  name       = "consul"
  chart      = "stable/consul"
  repository = data.helm_repository.stable.metadata[0].name
  namespace  = "kube-system"

  values = [data.template_file.consul.rendered]
}