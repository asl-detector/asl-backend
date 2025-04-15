variable "stats_table_name" {
  type        = string
  description = "Name of the DynamoDB table storing stats"
}

variable "dynamodb_policy_arn" {
  type        = string
  description = "ARN of the IAM policy that permits DynamoDB UpdateItem"
}