variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  region = var.aws_region
}

data "aws_eks_cluster_auth" "cluster" {
  name       = module.eks.cluster_id
  depends_on = [null_resource.wait_for_cluster]
}

resource "null_resource" "wait_for_cluster" {
  provisioner "local-exec" {
    command = "until curl -k -s $ENDPOINT/healthz > /dev/null; do sleep 4; done"
    environment = {
      ENDPOINT = module.eks.cluster_endpoint
    }
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    load_config_file       = false
  }
}

module "network" {
  source           = "github.com/insight-w3f/terraform-polkadot-aws-network.git?ref=master"
  num_azs          = 3
  k8s_enabled      = true
  root_domain_name = "test.internal"
}

module "eks" {
  source            = "github.com/insight-w3f/terraform-polkadot-aws-k8s-cluster.git?ref=master"
  security_group_id = module.network.k8s_security_group_id
  subnet_ids        = slice(module.network.public_subnets, 0, 3)
  vpc_id            = module.network.vpc_id
}

module "defaults" {
  source                 = "../.."
  all_enabled            = false
  consul_enabled         = true
  prometheus_enabled     = true
  nginx_ingress_enabled  = true
  elasticsearch_enabled  = true
  external_dns_enabled   = false
  cert_manager_enabled   = false
  cloud_platform         = "aws"
  region                 = var.aws_region
  deployment_domain_name = module.network.root_domain_name
  lb_endpoint            = "asg.internal"
  aws_worker_arn         = module.eks.worker_iam_role_arn
}
