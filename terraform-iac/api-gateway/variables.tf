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