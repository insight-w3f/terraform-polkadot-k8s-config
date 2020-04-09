
data "template_file" "consul" {
  template = yamlencode(yamldecode(file("${path.module}/consul.yaml")))
}


resource "helm_release" "consul" {
  name       = "consul"
  chart      = "consul"
  repository = data.helm_repository.stable.metadata[0].name
  namespace  = "kube-system"

  values = [data.template_file.consul.rendered]
}