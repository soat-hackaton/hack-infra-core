terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  
  # Configure seu backend S3 aqui se já tiver um bucket de estado
  backend "s3" {
    bucket = "seu-bucket-de-estado-existente"
    key    = "hack-infra-core/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}