output "lambda_invoke_arn" {
  description = "Invoke ARN for the get_stats Lambda function"
  value       = aws_lambda_function.lambda.invoke_arn
}

output "lambda_function_name" {
  description = "Function name of the get_stats Lambda"
  value       = aws_lambda_function.lambda.function_name
}

output "lambda_role_name" {
  description = "IAM Role name for the get_stats Lambda"
  value       = aws_iam_role.lambda_role.name
}