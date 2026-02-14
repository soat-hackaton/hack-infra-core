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
  tags        = { Environment = "dev", Project = "hackaton" }
}

# --- Módulo DynamoDB ---
module "video_metadata_table" {
  source = "../../modules/dynamo"

  table_name = var.video_dynamo_table_name
  tags       = { Environment = "dev", Project = "hackaton" }
}

module "users_table" {
  source = "../../modules/dynamo"

  table_name = var.users_dynamo_table_name
  tags       = { Environment = "dev", Project = "hackaton" }
}

# --- Módulo SQS ---
module "video_queue" {
  source = "../../modules/sqs"

  queue_name = var.sqs_queue_name
  tags       = { Environment = "dev", Project = "hackaton" }
}

# --- Módulo ECR ---
module "video_ecr" {
  source          = "../../modules/ecr"
  repository_name = "hack-video-ingest"
  tags            = { Environment = "dev", Project = "hackaton" }
}

module "auth_ecr" {
  source          = "../../modules/ecr"
  repository_name = "hack-auth"
  tags            = { Environment = "dev", Project = "hackaton" }
}

module "transcoder_ecr" {
  source          = "../../modules/ecr"
  repository_name = "hack-video-transcoder"
  tags            = { Environment = "dev", Project = "hackaton" }
}

module "worker_ecr" {
  source          = "../../modules/ecr"
  repository_name = "hack-video-worker"
  tags            = { Environment = "dev", Project = "hackaton" }
}

module "frontend_ecr" {
  source          = "../../modules/ecr"
  repository_name = "hack-frontend"
  tags            = { Environment = "dev", Project = "hackaton" }
}

# --- Módulo EKS ---
module "eks_cluster" {
  source       = "../../modules/eks"
  cluster_name = "hack-infra-eks"

  subnet_ids = local.cluster_subnet_ids

  # AWS Academy Configs
  lab_role_arn  = var.lab_role_arn
  principal_arn = var.principal_arn
  instance_type = "t3.medium"

  tags = { Environment = "dev", Project = "hackaton" }
}
