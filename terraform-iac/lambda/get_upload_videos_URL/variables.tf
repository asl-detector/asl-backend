variable "dataset_bucket_name" {
  description = "The name of the S3 bucket for dataset uploads"
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., prod, stage)."
  type        = string
}

variable "data_org_dataset_role_arn" {
  description = "The ARN of the IAM role in the data_org account that allows access to the dataset bucket"
  type        = string
}