variable "queue_name" {
  description = "Nome da fila SQS principal"
  type        = string
}

variable "delay_seconds" {
  description = "Tempo de atraso para entrega de mensagens (segundos)"
  type        = number
  default     = 0
}

variable "max_message_size" {
  description = "Tamanho máximo da mensagem em bytes (default 256KB)"
  type        = number
  default     = 262144
}

variable "message_retention_seconds" {
  description = "Tempo de retenção da mensagem (segundos)"
  type        = number
  default     = 86400 # 1 dia
}

variable "receive_wait_time_seconds" {
  description = "Tempo de Long Polling (segundos)"
  type        = number
  default     = 10 # Long polling ativado para reduzir custos e chamadas vazias
}

variable "tags" {
  description = "Tags para recursos"
  type        = map(string)
  default     = {}
}