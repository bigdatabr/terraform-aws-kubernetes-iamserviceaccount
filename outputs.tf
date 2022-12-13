output "service_account" {
  value       = try(data.kubernetes_service_account.this[0], kubernetes_service_account.this[0])
  description = "Service Account created / used by this module."
}

output "iam_role" {
  value       = aws_iam_role.this
  description = "IAM Role created by this module."
}
