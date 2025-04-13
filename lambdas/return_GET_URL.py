import boto3
import os
import json

s3 = boto3.client("s3")
bucket = os.environ["BUCKET_NAME"]

def handler(event, context):
    key = event.get("key", "uploads/some-default.mp4")  # path to the file

    try:
        url = s3.generate_presigned_url(
            "get_object",
            Params={"Bucket": bucket, "Key": key},
            ExpiresIn=300  # seconds (5 min)
        )

        return {
            "statusCode": 200,
            "body": json.dumps({"download_url": url}),
            "headers": {"Content-Type": "application/json"}
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }