# s3 bucket
module "s3" {
  source       = "../s3"
  project_name = var.project_name
  uuid         = var.uuid
}

# API Gateway
module "api_gateway" {
  source = "../api-gateway"
  project_name = var.project_name
  environment  = var.environment # Use environment variable

  get_download_model_weights_lambda_arn  = module.get_download_model_weights_URL.lambda_invoke_arn
  get_download_model_weights_lambda_name = module.get_download_model_weights_URL.lambda_function_name

  get_upload_model_monitoring_data_lambda_arn  = module.get_upload_model_monitoring_data_URL.lambda_invoke_arn
  get_upload_model_monitoring_data_lambda_name = module.get_upload_model_monitoring_data_URL.lambda_function_name

  get_upload_videos_lambda_arn  = module.get_upload_videos_URL.lambda_invoke_arn
  get_upload_videos_lambda_name = module.get_upload_videos_URL.lambda_function_name

  update_stats_lambda_arn  = module.update_stats.lambda_invoke_arn
  update_stats_lambda_name = module.update_stats.lambda_function_name

  get_stats_lambda_arn  = module.get_stats.lambda_invoke_arn
  get_stats_lambda_name = module.get_stats.lambda_function_name
}

# DynamoDB
module "dynamodb" {
  source      = "../dynamodb"
  environment = var.environment # Use environment variable
}

# Lambda functions
module "get_download_model_weights_URL" {
  source = "../lambda/get_download_model_weights_URL"
  environment = var.environment # Use environment variable

  model_serving_bucket_name = module.s3.model_serving_bucket_name
}

module "get_upload_model_monitoring_data_URL" {
  source = "../lambda/get_upload_model_monitoring_data_URL"
  environment = var.environment # Use environment variable

  monitoring_data_bucket_name = module.s3.monitoring_data_bucket_name
}

module "get_upload_videos_URL" {
  source = "../lambda/get_upload_videos_URL"
  environment = var.environment # Use environment variable

  dataset_bucket_name = module.s3.dataset_bucket_name
}

module "update_stats" {
  source              = "../lambda/update_stats"
  environment         = var.environment # Use environment variable
  stats_table_name    = module.dynamodb.app_stats_table_name
  dynamodb_policy_arn = module.dynamodb.dynamodb_update_stats_policy_arn
}

module "get_stats" {
  source              = "../lambda/get_stats"
  environment         = var.environment # Use environment variable
  stats_table_name    = module.dynamodb.app_stats_table_name
  stats_table_arn     = module.dynamodb.app_stats_table_arn
}