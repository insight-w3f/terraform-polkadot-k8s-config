
data "template_file" "elasticsearch" {
  template = yamlencode(yamldecode(file("${path.module}/elasticsearch.yaml")))
}


resource "helm_release" "elasticsearch" {
  count = var.elasticsearch_enabled ? 1 : 0
  name       = "elasticsearch"
  chart      = "stable/elasticsearch"
  repository = data.helm_repository.stable.metadata[0].name
  namespace  = "kube-system"

  values = [data.template_file.elasticsearch.rendered]
}