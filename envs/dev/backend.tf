terraform {
  backend "s3" {
    bucket = "hack-tfstate"
    key    = "infra-core/dev/terraform.tfstate"    
    region = "us-west-2"    
    encrypt = true
  }
}