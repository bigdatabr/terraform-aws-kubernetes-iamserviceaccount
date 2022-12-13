
variable "use_existing_service_account" {
  type        = bool
  default     = false
  description = "Whether or not `service_account_name` refers to an existing Service Account. It will be created otherwise."
}
variable "service_account_name" {
  type        = string
  description = "Name of the Service Account resource."
}
variable "namespace" {
  type        = string
  description = "Namespace for the Service Account"
}
variable "cluster_name" {
  type        = string
  description = "Name of the AWS EKS cluster."
}
variable "role_name" {
  type        = string
  description = "IAM role name."
}
variable "tags" {
  type        = map(string)
  description = "Tags to be inherited by AWS role"
  default     = {}
}
