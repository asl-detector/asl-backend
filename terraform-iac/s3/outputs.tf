output "dataset_bucket_arn" {
  description = "The ARN of the external training data S3 bucket."
  value = aws_s3_bucket.dataset_bucket.arn
}

output "dataset_bucket_id" {
  description = "The ID of the external training data S3 bucket."
  value = aws_s3_bucket.dataset_bucket.id
}

output "model_serving_bucket_arn" {
  description = "The ARN of the external training data S3 bucket."
  value = aws_s3_bucket.dataset_bucket.arn
}

output "model_serving_bucket_id" {
  description = "The ID of the external training data S3 bucket."
  value = aws_s3_bucket.dataset_bucket.id
}

output "monitoring_bucket_arn" {
  description = "The ARN of the external training data S3 bucket."
  value = aws_s3_bucket.dataset_bucket.arn
}

output "monitoring_bucket_id" {
  description = "The ID of the external training data S3 bucket."
  value = aws_s3_bucket.dataset_bucket.id
}