locals {
  name = var.id != "" ? "${replace(title(replace(var.id, "-", " ")), " ", "")}ExternalDnsRole" : null
}

resource "aws_iam_role" "external_dns" {
  count              = var.cloud_platform == "aws" ? 1 : 0
  name               = local.name
  assume_role_policy = data.aws_iam_policy_document.assume[0].json
}

resource "aws_iam_role_policy_attachment" "external_dns" {
  count      = var.cloud_platform == "aws" ? 1 : 0
  policy_arn = aws_iam_policy.dns_policy[0].arn
  role       = aws_iam_role.external_dns[0].id
}

resource "aws_iam_policy" "dns_policy" {
  count  = var.cloud_platform == "aws" ? 1 : 0
  policy = data.aws_iam_policy_document.dns_policy[0].json
}

data "aws_iam_policy_document" "assume" {
  count = var.cloud_platform == "aws" ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["ec2.amazonaws.com"]
      type        = "Service"
    }
  }

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = [var.aws_worker_arn]
      type        = "AWS"
    }
  }
}

data "aws_iam_policy_document" "dns_policy" {
  count = var.cloud_platform == "aws" ? 1 : 0
  statement {
    actions   = ["route53:ChangeResourceRecordSets"]
    effect    = "Allow"
    resources = ["arn:aws:route53:::hostedzone/*"]
  }

  statement {
    actions = ["route53:ListHostedZones",
    "route53:ListResourceRecordSets"]
    effect    = "Allow"
    resources = ["*"]
  }
}
