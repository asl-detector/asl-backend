variable "stats_table_name" {
  description = "Name of the DynamoDB table storing stats"
  type        = string
}

variable "stats_table_arn" {
  description = "ARN of the DynamoDB stats table"
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., prod, stage)."
  type        = string
}