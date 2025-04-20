output "dataset_bucket_arn" {
  description = "The ARN of the dataset bucket from data_org."
  value = data.aws_s3_bucket.dataset_bucket.arn
}

output "dataset_bucket_id" {
  description = "The ID of the dataset bucket from data_org."
  value = data.aws_s3_bucket.dataset_bucket.id
}

output "dataset_bucket_name" {
  description = "The name of the dataset bucket from data_org."
  value = data.aws_s3_bucket.dataset_bucket.bucket
}

output "dataset_cross_account_role_arn" {
  description = "The ARN of the role for cross-account access to the dataset bucket."
  value = aws_iam_role.dataset_cross_account_role.arn
}

output "model_serving_bucket_arn" {
  description = "The ARN of the model serving bucket from artifact_org."
  value = data.aws_s3_bucket.model_serving_bucket.arn
}

output "model_serving_bucket_id" {
  description = "The ID of the model serving bucket from artifact_org."
  value = data.aws_s3_bucket.model_serving_bucket.id
}

output "model_serving_bucket_name" {
  description = "The name of the model serving bucket from artifact_org."
  value = data.aws_s3_bucket.model_serving_bucket.bucket
}

output "model_serving_cross_account_role_arn" {
  description = "The ARN of the role for cross-account access to the model serving bucket."
  value = aws_iam_role.model_serving_cross_account_role.arn
}

output "monitoring_data_bucket_arn" {
  description = "The ARN of the monitoring data bucket from operations account."
  value = data.aws_s3_bucket.monitoring_data_bucket.arn
}

output "monitoring_data_bucket_id" {
  description = "The ID of the monitoring data bucket from operations account."
  value = data.aws_s3_bucket.monitoring_data_bucket.id
}

output "monitoring_data_bucket_name" {
  description = "The name of the monitoring data bucket from operations account."
  value = data.aws_s3_bucket.monitoring_data_bucket.bucket
}

output "monitoring_data_cross_account_role_arn" {
  description = "The ARN of the role for cross-account access to the monitoring data bucket."
  value = aws_iam_role.monitoring_data_cross_account_role.arn
}