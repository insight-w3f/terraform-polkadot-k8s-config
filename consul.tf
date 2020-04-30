
data "template_file" "consul" {
  template = yamlencode(yamldecode(file("${path.module}/consul.yaml")))
  vars = {
    region = var.region
  }
}


resource "helm_release" "consul" {
  count     = var.consul_enabled ? 1 : 0
  name      = "consul"
  chart     = "${path.module}/charts/consul"
  namespace = "kube-system"

  values = [data.template_file.consul.rendered]
}

resource "null_resource" "dns_stub" {
  provisioner "local-exec" {
    command = "${path.module}/scripts/create_consul_stub.sh"
    interpreter = [
      "/bin/bash",
    "-c"]
    environment = {
      KUBECONFIG = var.kubeconfig
      MODPATH    = path.module
    }
  }
  depends_on = [helm_release.consul]
}
