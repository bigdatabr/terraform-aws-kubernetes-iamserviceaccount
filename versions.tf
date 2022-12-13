terraform {
  required_version = ">= 0.13.1"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.20.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 1.0.0"
    }
  }
}
