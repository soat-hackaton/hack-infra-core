provider "aws" {
  region = var.aws_region
}

data "terraform_remote_state" "base_network" {
  backend = "s3"
  config = {
    bucket = "hack-tfstate" 
    key    = "infra-base/dev/terraform.tfstate"
    region = "us-west-2"
  }
}

locals {
  vpc_id             = data.terraform_remote_state.base_network.outputs.vpc_id
  node_subnet_ids    = data.terraform_remote_state.base_network.outputs.private_subnet_ids 
  cluster_subnet_ids = concat(
    data.terraform_remote_state.base_network.outputs.public_subnet_ids,
    data.terraform_remote_state.base_network.outputs.private_subnet_ids
  )
}

# --- Módulo S3 ---
module "video_bucket" {
  source = "../../modules/s3"

  bucket_name = var.s3_bucket_name
  tags        = { Environment = "dev", Project = "hack-video-ingest" }
}

# --- Módulo DynamoDB ---
module "video_metadata_table" {
  source = "../../modules/dynamo"

  table_name = var.dynamo_table_name
  tags       = { Environment = "dev", Project = "hack-video-ingest" }
}

# --- Módulo SQS ---
module "video_queue" {
  source = "../../modules/sqs"

  queue_name = var.sqs_queue_name
  tags       = { Environment = "dev", Project = "hack-video-ingest" }
}

# --- Módulo ECR ---
module "video_ecr" {
  source = "../../modules/ecr"
  repository_name = "hack-video-ingest"
  tags            = { Environment = "dev", Project = "hack-video-ingest" }
}

# --- Módulo EKS ---
module "eks_cluster" {
  source = "../../modules/eks"
  cluster_name = "hack-infra-eks"
  
  # Aqui usamos as subnets que vieram do outro projeto
  vpc_id     = local.vpc_id
  subnet_ids = local.node_subnet_ids 
  
  tags = { Environment = "dev", Project = "hack-video-ingest" }
}