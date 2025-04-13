import json
import boto3
import os
import uuid

s3 = boto3.client("s3")
bucket = os.environ["BUCKET_NAME"]

def handler(event, context):
    object_key = f"uploads/{uuid.uuid4()}.mp4"  # Or use event["filename"] if passed

    try:
        post = s3.generate_presigned_post(
            Bucket=bucket,
            Key=object_key,
            ExpiresIn=300,  # 5 minutes
            Conditions=[
                ["content-length-range", 0, 100_000_000]  # Max ~100MB
            ]
        )

        return {
            "statusCode": 200,
            "body": json.dumps({
                "url": post["url"],
                "fields": post["fields"],
                "object_key": object_key
            }),
            "headers": {"Content-Type": "application/json"}
        }
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)})
        }