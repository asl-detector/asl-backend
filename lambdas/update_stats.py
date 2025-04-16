import os
import boto3
import json

dynamodb = boto3.client("dynamodb")
table_name = os.environ.get("STATS_TABLE")

def handler(event, context):
    # Parse the payload. If the API Gateway is used, the JSON payload is expected
    # to be in event["body"]. Otherwise, the payload is expected at the top level.
    try:
        if "body" in event and event["body"]:
            payload = json.loads(event["body"])
        else:
            payload = event
    except Exception as e:
        return {
            "statusCode": 400,
            "body": json.dumps({"error": "Invalid JSON in the request body."})
        }

    # Retrieve the user_id from the payload.
    user_id = payload.get("user_id")
    if not user_id:
        return {
            "statusCode": 400,
            "body": json.dumps({"error": "Missing 'user_id' in request."})
        }

    # Retrieve the values to update.
    # If any value is missing in the payload, default to 0.
    videos = payload.get("videos_uploaded", 0)
    minutes = payload.get("minutes_uploaded", 0)
    words = payload.get("words_translated", 0)

    try:
        # Update the DynamoDB item using the SET update operator to overwrite
        # existing values with the new values.
        dynamodb.update_item(
            TableName=table_name,
            Key={"user_id": {"S": user_id}},
            UpdateExpression="SET videos_uploaded = :v, minutes_uploaded = :m, words_translated = :w",
            ExpressionAttributeValues={
                ":v": {"N": str(videos)},
                ":m": {"N": str(minutes)},
                ":w": {"N": str(words)}
            }
        )
        return {
            "statusCode": 200,
            "body": json.dumps({"message": f"Stats updated successfully for user: {user_id}"})
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }