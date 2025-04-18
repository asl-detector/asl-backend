import os
import json
import uuid

import boto3
from botocore.client import Config

# force SigV4 so we get POST creds that work in us‑west‑2
s3 = boto3.client(
    "s3",
    config=Config(signature_version="s3v4"),
    region_name=os.environ.get("AWS_REGION", "us-west-2")
)

BUCKET = os.environ["BUCKET_NAME"]

def handler(event, context):
    # preserve extension if caller passed one
    name = event.get("filename", "")
    ext  = os.path.splitext(name)[1] or ".mp4"
    key  = f"uploads/{uuid.uuid4()}{ext}"

    try:
        post = s3.generate_presigned_post(
            Bucket     = BUCKET,
            Key        = key,
            # optional extra security:
            # Fields     = {"acl": "private"},
            Conditions = [
                ["starts-with", "$key", "uploads/"],
                # ["eq", "$acl", "private"],        # if you set Fields above
            ],
            ExpiresIn  = 300
        )

        return {
            "statusCode": 200,
            "headers":    {"Content-Type": "application/json"},
            "body":       json.dumps(post),
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "headers":    {"Content-Type": "application/json"},
            "body":       json.dumps({"error": str(e)}),
        }