import os
import json
import uuid

import boto3
from botocore.client import Config

def get_cross_account_s3_client():
    # First assume the cross-account role
    sts_client = boto3.client('sts')
    
    # Get the role ARN from environment variable
    operations_role_arn = os.environ.get("CROSS_ACCOUNT_ROLE_ARN")
    
    if operations_role_arn:
        try:
            # Assume the role in the operations account
            assumed_role = sts_client.assume_role(
                RoleArn=operations_role_arn,
                RoleSessionName="LambdaCrossAccountS3Access"
            )
            
            # Create an S3 client using the temporary credentials from the assumed role
            s3 = boto3.client(
                "s3",
                config=Config(signature_version="s3v4"),
                region_name=os.environ.get("AWS_REGION", "us-west-2"),
                aws_access_key_id=assumed_role['Credentials']['AccessKeyId'],
                aws_secret_access_key=assumed_role['Credentials']['SecretAccessKey'],
                aws_session_token=assumed_role['Credentials']['SessionToken']
            )
            return s3
        except Exception as e:
            print(f"Error assuming role: {str(e)}")
            
    # Fall back to default credentials if role assumption fails or no role ARN provided
    s3 = boto3.client(
        "s3",
        config=Config(signature_version="s3v4"),
        region_name=os.environ.get("AWS_REGION", "us-west-2")
    )
    return s3

# Get a properly configured S3 client that can access cross-account resources
s3 = get_cross_account_s3_client()

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