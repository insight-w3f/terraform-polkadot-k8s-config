

module "eks" {
  source = "github.com/insight-w3f/terraform-polkadot-aws-k8s-cluster.git?ref=master"
}

module "defaults" {
  source = "../.."
}
