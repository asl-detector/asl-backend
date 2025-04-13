module "s3" {
  source       = "./terraform-iac/s3"
  project_name = var.project_name
  uuid         = var.uuid
}

module "get_download_model_weights_URL" {
  source = "./terraform-iac/lambda/get_download_model_weights_URL"

  model_serving_bucket_name = module.s3.model_serving_bucket_name
}

module "get_upload_model_monitoring_data_URL" {
  source = "./terraform-iac/lambda/get_upload_model_monitoring_data_URL"

  monitoring_data_bucket_name = module.s3.monitoring_data_bucket_name
}

module "get_upload_videos_URL" {
  source = "./terraform-iac/lambda/get_upload_videos_URL"

  dataset_bucket_name = module.s3.dataset_bucket_name
}

module "update_stats" {
  source = "./terraform-iac/lambda/update_stats"
}