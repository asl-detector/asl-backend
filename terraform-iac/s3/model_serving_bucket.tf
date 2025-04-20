# Use data source to reference the existing model serving bucket from artifact_org
data "aws_s3_bucket" "model_serving_bucket" {
  bucket = var.artifact_model_serving_bucket_name
}

# Create IAM role for Lambda to assume the role in artifact_org account
resource "aws_iam_role" "model_serving_cross_account_role" {
  name = "${var.project_name}-model-serving-access-role"
  
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

# Allow lambda to assume the role from artifact_org account
resource "aws_iam_role_policy" "assume_artifact_role_policy" {
  name = "assume-artifact-role-policy"
  role = aws_iam_role.model_serving_cross_account_role.id
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = "sts:AssumeRole",
      Resource = var.artifact_model_serving_role_arn
    }]
  })
}