resource "aws_iam_role" "lambda_role" {
  name = "get_model_weights_url_lambda_role"

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

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/../../../lambdas/return_GET_URL.py"
  output_path = "${path.module}/return_GET_URL.zip"
}

resource "aws_lambda_function" "lambda" {
  function_name = "get_download_model_weights_URL_lambda"
  role          = aws_iam_role.lambda_role.arn
  handler       = "return_GET_URL.handler"  # file.function
  runtime       = "python3.11"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  timeout     = 10
  memory_size = 256

  # This is for the Lambda function to access the S3 bucket
  environment {
    variables = {
      BUCKET_NAME = var.model_serving_bucket_name
    }
  }
}