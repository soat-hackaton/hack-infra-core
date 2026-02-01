output "bucket_id" {
  description = "ID do Bucket (Nome)"
  value       = aws_s3_bucket.this.id
}

output "bucket_arn" {
  description = "ARN do Bucket"
  value       = aws_s3_bucket.this.arn
}