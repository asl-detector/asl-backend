import os
import boto3
import json

dynamodb = boto3.client('dynamodb')
table_name = os.environ.get("STATS_TABLE")

def handler(event, context):
    # Get the user id from the event payload; default to "global" if not provided
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

        # Convert DynamoDB attributes to a normal Python dict.
        stats = {}
        for key, value in item.items():
            if "N" in value:
                # Convert number strings to integers
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