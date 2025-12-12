terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.8.0"
    }
  }
}


provider "aws" {
  region = "eu-north-1"  # Stockholm region
}