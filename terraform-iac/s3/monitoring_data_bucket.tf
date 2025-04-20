/* 
   Instead of creating a local monitoring data bucket, we're using the shared one from operations account
   Original code is commented out below for reference

resource "aws_s3_bucket" "monitoring_data_bucket" {
  bucket        = "${var.project_name}-monitoring-data-bucket-${var.uuid}"
  force_destroy = false
}

resource "aws_s3_bucket_server_side_encryption_configuration" "monitoring_data_bucket_encryption" {
  bucket = aws_s3_bucket.monitoring_data_bucket.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "monitoring_data_bucket_public_access" {
  bucket = aws_s3_bucket.monitoring_data_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
*/

# Use data source to reference the existing monitoring data bucket from operations account
data "aws_s3_bucket" "monitoring_data_bucket" {
  bucket = var.operations_monitoring_bucket_name
}

# Create IAM role for Lambda to assume the role in operations account
resource "aws_iam_role" "monitoring_data_cross_account_role" {
  name = "${var.project_name}-monitoring-data-access-role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

# Allow lambda to assume the role from operations account
resource "aws_iam_role_policy" "assume_operations_role_policy" {
  name = "assume-operations-role-policy"
  role = aws_iam_role.monitoring_data_cross_account_role.id
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = "sts:AssumeRole",
      Resource = var.operations_monitoring_role_arn
    }]
  })
}