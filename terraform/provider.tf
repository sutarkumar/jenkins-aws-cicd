terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "jenkins-aws-cicd"
      ManagedBy   = "Terraform"
      Environment = "dev"
    }
  }
}

variable "aws_region" {
  description = "AWS Region for deploying resources"
  type        = string
  default     = "ap-south-1"
}

