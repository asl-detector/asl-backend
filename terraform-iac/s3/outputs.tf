output "dataset_bucket_arn" {
  description = "The ARN of the external training data S3 bucket."
  value = aws_s3_bucket.dataset_bucket.arn
}

output "dataset_bucket_id" {
  description = "The ID of the external training data S3 bucket."
  value = aws_s3_bucket.dataset_bucket.id
}

output "dataset_bucket_name" {
  value = aws_s3_bucket.dataset_bucket.bucket
}

output "model_serving_bucket_arn" {
  description = "The ARN of the external training data S3 bucket."
  value = aws_s3_bucket.model_serving_bucket.arn
}

output "model_serving_bucket_id" {
  description = "The ID of the external training data S3 bucket."
  value = aws_s3_bucket.model_serving_bucket.id
}

output "model_serving_bucket_name" {
  value = aws_s3_bucket.model_serving_bucket.bucket
}

output "monitoring_data_bucket_arn" {
  description = "The ARN of the external training data S3 bucket."
  value = aws_s3_bucket.monitoring_data_bucket.arn
}

output "monitoring_data_bucket_id" {
  description = "The ID of the external training data S3 bucket."
  value = aws_s3_bucket.monitoring_data_bucket.id
}

output "monitoring_data_bucket_name" {
  value = aws_s3_bucket.monitoring_data_bucket.bucket
}