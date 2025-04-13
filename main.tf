module "s3" {
  source       = "./terraform-iac/s3"
  project_name = var.project_name
  uuid         = var.uuid
}