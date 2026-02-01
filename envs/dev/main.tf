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