variable "table_name" {
  description = "Nome da tabela DynamoDB"
  type        = string
}

variable "tags" {
  description = "Tags para recursos"
  type        = map(string)
  default     = {}
}

variable "additional_attributes" {
  description = "Lista de atributos adicionais para índices (ex: user_email, created_at)"
  type = list(object({
    name = string
    type = string
  }))
  default = []
}

variable "global_secondary_indexes" {
  description = "Lista de índices globais secundários (GSI)"
  type = list(object({
    name            = string
    hash_key        = string
    range_key       = optional(string)
    projection_type = string
  }))
  default = []
}