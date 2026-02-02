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

output "ecr_repository_url" {
  description = "URL do ECR para push da imagem"
  value       = module.video_ecr.repository_url
}

output "eks_cluster_name" {
  description = "Nome do Cluster EKS"
  value       = module.eks_cluster.cluster_name
}