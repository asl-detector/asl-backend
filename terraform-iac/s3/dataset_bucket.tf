resource "aws_s3_bucket" "dataset_bucket" {
  bucket        = "${var.project_name}-dataset-bucket-${var.uuid}"
  force_destroy = false
}

resource "aws_s3_bucket_server_side_encryption_configuration" "dataset_bucket_encryption" {
  bucket = aws_s3_bucket.dataset_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "dataset_bucket_public_access" {
  bucket = aws_s3_bucket.dataset_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  depends_on = [aws_s3_bucket.dataset_bucket]
}