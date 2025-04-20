variable "monitoring_data_bucket_name" {
  description = "The name of the S3 bucket for model weights"
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., prod, stage)."
  type        = string
}

variable "operations_monitoring_role_arn" {
  description = "The ARN of the IAM role in the operations account that allows access to the monitoring data bucket"
  type        = string
}