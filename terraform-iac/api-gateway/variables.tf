variable "get_download_model_weights_lambda_arn" {
  description = "Invoke ARN of the get_download_model_weights Lambda"
  type        = string
}

variable "get_download_model_weights_lambda_name" {
  description = "Function name of the get_download_model_weights Lambda"
  type        = string
}

variable "get_upload_model_monitoring_data_lambda_arn" {
  type        = string
  description = "Invoke ARN for get_upload_model_monitoring_data"
}

variable "get_upload_model_monitoring_data_lambda_name" {
  type        = string
  description = "Function name for get_upload_model_monitoring_data"
}

variable "get_upload_videos_lambda_arn" {
  type        = string
  description = "Invoke ARN for get_upload_videos"
}

variable "get_upload_videos_lambda_name" {
  type        = string
  description = "Function name for get_upload_videos"
}

variable "update_stats_lambda_arn" {
  description = "Invoke ARN of the update_stats Lambda"
  type        = string
}

variable "update_stats_lambda_name" {
  description = "Function name of the update_stats Lambda"
  type        = string
}

variable "get_stats_lambda_arn" {
  description = "The invoke ARN for the get_stats Lambda function"
  type        = string
}

variable "get_stats_lambda_name" {
  description = "The function name for the get_stats Lambda function"
  type        = string
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "API Gateway stage/environment (dev, stage, prod …)"
  type        = string
}