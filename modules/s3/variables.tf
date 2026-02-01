variable "bucket_name" {
  description = "Nome único do bucket S3"
  type        = string
}

variable "tags" {
  description = "Tags para recursos"
  type        = map(string)
  default     = {}
}