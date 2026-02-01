output "queue_url" {
  description = "URL da Fila Principal (Usado pela API Python)"
  value       = aws_sqs_queue.this.id
}

output "queue_arn" {
  description = "ARN da Fila Principal"
  value       = aws_sqs_queue.this.arn
}

output "dlq_url" {
  description = "URL da Dead Letter Queue"
  value       = aws_sqs_queue.dlq.id
}