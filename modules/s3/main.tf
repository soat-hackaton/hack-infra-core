resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  force_destroy = true # Útil em hackathons para limpar fácil

  tags = var.tags
}

# Configuração de CORS (Obrigatória para Presigned URLs no browser)
resource "aws_s3_bucket_cors_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "POST", "GET"]
    allowed_origins = ["*"] # Em produção, troque pelo domínio do frontend
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}

# Bloqueio de acesso público (Boas práticas - o acesso é via URL assinada)
resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}