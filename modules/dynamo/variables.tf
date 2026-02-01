variable "table_name" {
  description = "Nome da tabela DynamoDB"
  type        = string
}

variable "tags" {
  description = "Tags para recursos"
  type        = map(string)
  default     = {}
}