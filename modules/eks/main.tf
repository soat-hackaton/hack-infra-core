# 1. Cluster EKS
resource "aws_eks_cluster" "this" {
  name     = var.cluster_name
  role_arn = var.lab_role_arn
  version  = "1.30"

  vpc_config {
    subnet_ids = var.subnet_ids
    endpoint_public_access = true
  }

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  tags = var.tags
}

# 2. Node Group
resource "aws_eks_node_group" "this" {
  cluster_name    = aws_eks_cluster.this.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = var.lab_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  instance_types = [var.instance_type]

  tags = var.tags
}

# 3. Configuração de Acesso

# Define QUEM pode acessar (Você/voclabs)
resource "aws_eks_access_entry" "admin" {
  cluster_name  = aws_eks_cluster.this.name
  principal_arn = var.principal_arn
  type          = "STANDARD"
}

# Define O QUE ele pode fazer (Admin)
resource "aws_eks_access_policy_association" "admin_policy" {
  cluster_name  = aws_eks_cluster.this.name
  policy_arn    = var.access_policy_arn
  principal_arn = aws_eks_access_entry.admin.principal_arn

  access_scope {
    type = "cluster"
  }
}