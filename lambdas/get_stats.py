import os
import boto3
import json

dynamodb = boto3.client('dynamodb')
table_name = os.environ.get("STATS_TABLE")

def handler(event, context):
    # Attempt to get user_id from the query parameters first.
    user_id = None
    if event.get("queryStringParameters"):
        user_id = event["queryStringParameters"].get("user_id")

    # Fall back to top-level field if necessary.
    if not user_id:
        user_id = event.get("user_id", "global")

    try:
        response = dynamodb.get_item(
            TableName=table_name,
            Key={
                "user_id": {"S": user_id}
            }
        )
        item = response.get("Item")
        if not item:
            return {
                "statusCode": 404,
                "body": json.dumps({"error": f"Stats not found for user: {user_id}"})
            }

        # Convert the DynamoDB item to a standard Python dictionary.
        stats = {}
        for key, value in item.items():
            if "N" in value:
                stats[key] = int(value["N"])
            elif "S" in value:
                stats[key] = value["S"]
            else:
                stats[key] = value

        return {
            "statusCode": 200,
            "body": json.dumps(stats)
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }