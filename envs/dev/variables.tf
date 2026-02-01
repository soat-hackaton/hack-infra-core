variable "s3_bucket_name" {
  description = "Nome do Bucket para vídeos (deve ser único globalmente)"
  type        = string
  default     = "hack-uploaded-videos"
}

variable "dynamo_table_name" {
  description = "Nome da tabela de metadados"
  type        = string
  default     = "hack-video-processing-db"
}

variable "sqs_queue_name" {
  description = "Nome da fila SQS"
  type        = string
  default     = "hack-video-processing-queue"
}

variable "aws_region" {
  description = "Região da AWS (Configurado para us-west-2 conforme AWS Academy)"
  type        = string
  default     = "us-west-2" # Oregon
}