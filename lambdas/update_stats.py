import json
import os
import boto3

dynamodb = boto3.client("dynamodb")
table_name = os.environ["STATS_TABLE"]

def handler(event, context):
    try:
        # API Gateway proxy integration sends the body as a JSON string
        body = json.loads(event.get("body", "{}"))
    except json.JSONDecodeError:
        return {
            "statusCode": 400,
            "body": "Invalid JSON body."
        }

    user_id = body.get("user_id")
    if not user_id:
        return {
            "statusCode": 400,
            "body": "Missing 'user_id' in request."
        }

    minutes = body.get("minutes_uploaded", 0)
    words = body.get("words_translated", 0)

    try:
        dynamodb.update_item(
            TableName=table_name,
            Key={"user_id": {"S": user_id}},
            UpdateExpression="ADD videos_uploaded :v, minutes_uploaded :m, words_translated :w",
            ExpressionAttributeValues={
                ":v": {"N": "1"},
                ":m": {"N": str(minutes)},
                ":w": {"N": str(words)}
            }
        )
        return {
            "statusCode": 200,
            "body": f"Stats updated successfully for user: {user_id}."
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": str(e)
        }