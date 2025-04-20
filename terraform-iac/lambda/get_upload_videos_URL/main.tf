resource "aws_iam_role" "lambda_role" {
  name = "get_upload_videos_url_lambda_role-${var.environment}" # Add environment suffix

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = { Service = "lambda.amazonaws.com" },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_logs" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# Add policy for assuming cross-account role in data_org account
resource "aws_iam_role_policy" "cross_account_assume_role" {
  name = "cross-account-assume-role-policy"
  role = aws_iam_role.lambda_role.id
  
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = "sts:AssumeRole",
      Resource = var.data_org_dataset_role_arn
    }]
  })
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/../../../lambdas/return_POST_URL.py"
  output_path = "${path.module}/return_POST_URL.zip"
}

resource "aws_lambda_function" "lambda" {
  function_name = "get_upload_videos_URL_lambda-${var.environment}" # Add environment suffix
  role          = aws_iam_role.lambda_role.arn
  handler       = "return_POST_URL.handler"
  runtime       = "python3.11"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  timeout     = 10
  memory_size = 256

  environment {
    variables = {
      BUCKET_NAME = var.dataset_bucket_name,
      CROSS_ACCOUNT_ROLE_ARN = var.data_org_dataset_role_arn
    }
  }
}

resource "aws_iam_role_policy" "lambda_s3_upload" {
  name = "lambda-s3-upload-${var.environment}" # Add environment suffix
  role = aws_iam_role.lambda_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl"
        ]
        Resource = "arn:aws:s3:::${var.dataset_bucket_name}/uploads/*"
      }
    ]
  })
}