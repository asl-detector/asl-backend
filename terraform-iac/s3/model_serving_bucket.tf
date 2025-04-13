resource "aws_s3_bucket" "model_serving_bucket" {
  bucket        = "${var.project_name}-model-serving-bucket-${var.uuid}"
  force_destroy = false
}

resource "aws_s3_bucket_server_side_encryption_configuration" "model_serving_bucket_encryption" {
  bucket = aws_s3_bucket.model_serving_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "model_serving_bucket_public_access" {
  bucket = aws_s3_bucket.model_serving_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}