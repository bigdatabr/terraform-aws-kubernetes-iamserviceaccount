locals {
  oidc_provider = trimprefix(data.aws_eks_cluster.cluster.identity[0].oidc[0].issuer, "https://")
}

############################################
#         Create Service Account
############################################
resource "kubernetes_service_account" "this" {
  count = var.use_existing_service_account ? 0 : 1

  metadata {
    name      = var.service_account_name
    namespace = var.namespace
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.this.arn
    }
  }
}


############################################
#       Use existing Service Account
############################################
data "kubernetes_service_account" "this" {
  count = var.use_existing_service_account ? 1 : 0

  metadata {
    name      = var.service_account_name
    namespace = var.namespace
  }
}
resource "kubernetes_annotations" "link_role_to_service_account" {
  count = var.use_existing_service_account ? 1 : 0

  api_version = "v1"
  kind        = "ServiceAccount"
  metadata {
    name      = var.service_account_name
    namespace = var.namespace
  }
  annotations = {
    "eks.amazonaws.com/role-arn" = aws_iam_role.this.arn
  }
  depends_on = [
    data.kubernetes_service_account.this
  ]
}

############################################
#                   AWS
############################################
resource "aws_iam_role" "this" {
  name = var.role_name
  assume_role_policy = jsonencode(
    {
      Version = "2012-10-17"
      Statement = [
        {
          Effect = "Allow"
          Action = "sts:AssumeRoleWithWebIdentity"
          Principal = {
            Federated = "arn:aws:iam::${local.account_id}:oidc-provider/${local.oidc_provider}"
          }
          Condition = {
            StringEquals = {
              "${local.oidc_provider}:aud" = "sts.amazonaws.com"
              "${local.oidc_provider}:sub" = "system:serviceaccount:${var.namespace}:${var.service_account_name}"
            }
          }
        }
      ]
    }
  )
  tags = var.tags
}
