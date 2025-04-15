resource "aws_dynamodb_table" "app_stats" {
  name           = "asl-app-stats"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "user_id"

  attribute {
    name = "user_id"
    type = "S"
  }

  tags = {
    Environment = "prod"
    App         = "asl-database"
  }
}

resource "aws_iam_policy" "dynamodb_update_stats_policy" {
  name = "DynamoDBUpdateStats"

  policy = jsonencode({
    Version   = "2012-10-17",
    Statement = [{
      Effect   = "Allow",
      Action   = [
        "dynamodb:UpdateItem",
        "dynamodb:GetItem"
      ],
      Resource = aws_dynamodb_table.app_stats.arn
    }]
  })
}