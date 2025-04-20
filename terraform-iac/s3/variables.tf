variable "project_name" {
  description = "The name of the project, this is used throughout to rename resources."
  type        = string
}

variable "uuid" {
  description = "A unique identifier that will be appended to various names."
  type        = string
  default     = "asl-dataset-00"
}

variable "artifact_model_serving_bucket_name" {
  description = "The name of the model serving bucket from the artifact_org account"
  type        = string
}

variable "artifact_model_serving_role_arn" {
  description = "The ARN of the IAM role for accessing the model serving bucket in the artifact_org account"
  type        = string
}

variable "operations_monitoring_bucket_name" {
  description = "The name of the monitoring data bucket from the operations account"
  type        = string
}

variable "operations_monitoring_role_arn" {
  description = "The ARN of the IAM role for accessing the monitoring data bucket in the operations account"
  type        = string
}

variable "data_captured_dataset_bucket_name" {
  description = "The name of the captured dataset bucket from the data_org account"
  type        = string
}

variable "data_captured_dataset_role_arn" {
  description = "The ARN of the IAM role for accessing the captured dataset bucket in the data_org account"
  type        = string
}