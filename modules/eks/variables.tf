variable "cluster_name" { type = string }
variable "subnet_ids" { type = list(string) }
variable "tags" { type = map(string) }

# --- Variáveis Específicas do AWS Academy ---
variable "access_policy_arn" {
  description = "ARN da política de acesso ao cluster (ex: ClusterAdmin)"
  type        = string
  default     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
}

variable "instance_type" {
  description = "Tipo de instância dos nodes"
  type        = string
  default     = "t3.medium"
}

variable "lab_role_arn" {
  description = "ARN da LabRole (Verifique no console AWS se o Account ID mudou!)"
  type        = string
}

variable "principal_arn" {
  description = "ARN do usuário logado (voclabs)"
  type        = string
}