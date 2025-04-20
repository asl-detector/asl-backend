# Use data source to reference the existing captured dataset bucket from data_org account
data "aws_s3_bucket" "dataset_bucket" {
  bucket = var.data_captured_dataset_bucket_name
}

# Create IAM role for Lambda to assume the role in data_org account
resource "aws_iam_role" "dataset_cross_account_role" {
  name = "${var.project_name}-dataset-access-role"
  
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

# Allow lambda to assume the role from data_org account
resource "aws_iam_role_policy" "assume_data_org_dataset_role_policy" {
  name = "assume-data-org-dataset-role-policy"
  role = aws_iam_role.dataset_cross_account_role.id
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = "sts:AssumeRole",
      Resource = var.data_captured_dataset_role_arn
    }]
  })
}