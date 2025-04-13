output "get_download_model_weights_endpoint" {
  value = "${aws_api_gateway_deployment.api_deployment.invoke_url}/get-download-model-weights"
}