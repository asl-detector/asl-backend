variable "monitoring_data_bucket_name" {
  description = "The name of the S3 bucket for model weights"
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., prod, stage)."
  type        = string
}