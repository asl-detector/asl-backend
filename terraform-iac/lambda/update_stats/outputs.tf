output "lambda_invoke_arn" {
  value = aws_lambda_function.update_stats.invoke_arn
}

output "lambda_function_name" {
  value = aws_lambda_function.update_stats.function_name
}

output "lambda_role_name" {
  value = aws_iam_role.lambda_role.name
}