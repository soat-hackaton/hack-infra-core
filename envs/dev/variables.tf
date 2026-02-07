# S3
variable "s3_bucket_name" {
  description = "Nome do Bucket para vídeos (deve ser único globalmente)"
  type        = string
  default     = "hack-uploaded-videos"
}

# DynamoDB
variable "video_dynamo_table_name" {
  description = "Nome da tabela de metadados"
  type        = string
  default     = "hack-video-processing-db"
}

variable "users_dynamo_table_name" {
  description = "Nome da tabela de usuários"
  type        = string
  default     = "hack-users-db"
}

# SQS
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

# EKS
variable "lab_role_arn" {
  description = "ARN da Role do Academy"
  type        = string
  default     = "arn:aws:iam::948109974561:role/LabRole" 
}

variable "principal_arn" {
  description = "ARN do usuário logado (voclabs)"
  type        = string
  default     = "arn:aws:iam::948109974561:role/voclabs"
}