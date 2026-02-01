output "video_bucket_name" {
  value = module.video_bucket.bucket_id
}

output "metadata_table_name" {
  value = module.video_metadata_table.table_name
}

output "sqs_queue_url" {
  description = "URL da fila SQS para configurar na API (SQS_QUEUE_URL)"
  value       = module.video_queue.queue_url
}