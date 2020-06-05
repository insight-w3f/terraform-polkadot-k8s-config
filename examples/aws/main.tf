variable "aws_region" {
  default = "us-east-1"
}

provider "aws" {
  region = var.aws_region
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
    token                  = data.aws_eks_cluster_auth.cluster.token
    load_config_file       = false
  }
}

module "network" {
  source      = "github.com/insight-w3f/terraform-polkadot-aws-network.git?ref=master"
  num_azs     = 3
  k8s_enabled = true
}

module "eks" {
  source            = "github.com/insight-w3f/terraform-polkadot-aws-k8s-cluster.git?ref=master"
  security_group_id = module.network.k8s_security_group_id
  subnet_ids        = slice(module.network.public_subnets, 0, 3)
  vpc_id            = module.network.vpc_id
}

module "defaults" {
  source             = "../.."
  prometheus_enabled = true
  cloud_platform     = "aws"
  region             = var.aws_region
}
