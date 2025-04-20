variable "model_serving_bucket_name" {
  description = "The name of the S3 bucket for model weights"
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., prod, stage)."
  type        = string
}

variable "artifact_model_role_arn" {
  description = "The ARN of the IAM role in the artifact account that allows access to the model serving bucket"
  type        = string
}