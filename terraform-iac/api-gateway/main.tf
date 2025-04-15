resource "aws_api_gateway_rest_api" "api" {
  name        = "asl-api"
  description = "API for ASL Lambda functions"
}

resource "aws_api_gateway_resource" "get_download_model_weights_URL" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "get-download-model-weights_URL"
}

resource "aws_api_gateway_method" "get_download_model_weights" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.get_download_model_weights_URL.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_download_model_weights" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.get_download_model_weights_URL.id
  http_method             = aws_api_gateway_method.get_download_model_weights.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.get_download_model_weights_lambda_arn
}

resource "aws_lambda_permission" "apigw_get_download_model_weights" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.get_download_model_weights_lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

resource "aws_api_gateway_resource" "get_upload_model_monitoring_data_URL" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "get-upload-model-monitoring-data"
}

resource "aws_api_gateway_method" "get_upload_model_monitoring_data" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.get_upload_model_monitoring_data_URL.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_upload_model_monitoring_data" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.get_upload_model_monitoring_data_URL.id
  http_method             = aws_api_gateway_method.get_upload_model_monitoring_data.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.get_upload_model_monitoring_data_lambda_arn
}

resource "aws_lambda_permission" "allow_apigw_get_upload_model_monitoring_data" {
  statement_id  = "AllowAPIGatewayInvokeMonitoringUpload"
  action        = "lambda:InvokeFunction"
  function_name = var.get_upload_model_monitoring_data_lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

resource "aws_api_gateway_resource" "get_upload_videos_URL" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "get-upload-videos"
}

resource "aws_api_gateway_method" "get_upload_videos" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.get_upload_videos_URL.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_upload_videos" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.get_upload_videos_URL.id
  http_method             = aws_api_gateway_method.get_upload_videos.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.get_upload_videos_lambda_arn
}

resource "aws_lambda_permission" "allow_apigw_get_upload_videos" {
  statement_id  = "AllowAPIGatewayInvokeVideoUpload"
  action        = "lambda:InvokeFunction"
  function_name = var.get_upload_videos_lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

resource "aws_api_gateway_resource" "update_stats" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "update-stats"
}

resource "aws_api_gateway_method" "update_stats" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.update_stats.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "update_stats" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.update_stats.id
  http_method             = aws_api_gateway_method.update_stats.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.update_stats_lambda_arn
}

resource "aws_lambda_permission" "update_stats_permission" {
  statement_id  = "AllowAPIGatewayInvokeUpdateStats"
  action        = "lambda:InvokeFunction"
  function_name = var.update_stats_lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

resource "aws_api_gateway_resource" "get_stats_resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "get-stats"
}

resource "aws_api_gateway_method" "get_stats" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.get_stats_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_stats" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.get_stats_resource.id
  http_method             = aws_api_gateway_method.get_stats.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.get_stats_lambda_arn
}

resource "aws_lambda_permission" "get_stats_permission" {
  statement_id  = "AllowAPIGatewayInvokeGetStats"
  action        = "lambda:InvokeFunction"
  function_name = var.get_stats_lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.api.execution_arn}/*/*"
}

# Deployment
resource "aws_api_gateway_deployment" "api_deployment" {
  depends_on = [
    aws_api_gateway_integration.get_download_model_weights,
    aws_api_gateway_integration.get_upload_model_monitoring_data,
    aws_api_gateway_integration.get_upload_videos,
    aws_api_gateway_integration.update_stats,
    aws_api_gateway_integration.get_stats
  ]
  rest_api_id = aws_api_gateway_rest_api.api.id
}

resource "aws_api_gateway_stage" "prod" {
  stage_name    = "prod"
  rest_api_id   = aws_api_gateway_rest_api.api.id
  deployment_id = aws_api_gateway_deployment.api_deployment.id
}