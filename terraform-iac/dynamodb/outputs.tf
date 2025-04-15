output "app_stats_table_name" {
  value = aws_dynamodb_table.app_stats.name
}

output "dynamodb_update_stats_policy_arn" {
  value       = aws_iam_policy.dynamodb_update_stats_policy.arn
  description = "ARN of the DynamoDB update stats IAM policy"
}