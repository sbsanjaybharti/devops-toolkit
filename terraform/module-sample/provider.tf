terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 5.97.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.25.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.17.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
