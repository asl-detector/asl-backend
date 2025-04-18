variable "dataset_bucket_name" {
  description = "The S3 bucket for uploading videos"
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., prod, stage)."
  type        = string
}