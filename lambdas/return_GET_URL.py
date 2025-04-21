import boto3
import os
import json

def get_cross_account_s3_client():
    sts = boto3.client("sts")
    role_arn = os.environ.get("CROSS_ACCOUNT_ROLE_ARN")
    if role_arn:
        creds = sts.assume_role(
            RoleArn=role_arn,
            RoleSessionName="LambdaCrossAccountModelAccess"
        )["Credentials"]
        return boto3.client(
            "s3",
            region_name=os.environ.get("AWS_REGION", "us-west-2"),
            aws_access_key_id=creds["AccessKeyId"],
            aws_secret_access_key=creds["SecretAccessKey"],
            aws_session_token=creds["SessionToken"],
        )
    return boto3.client("s3")

s3     = get_cross_account_s3_client()
bucket = os.environ["BUCKET_NAME"]

def handler(event, context):
    # 1) unwrap the POST body
    try:
        body = json.loads(event.get("body", "{}"))
    except json.JSONDecodeError:
        return {
            "statusCode": 400,
            "body": json.dumps({"error": "Invalid JSON"}),
            "headers": {"Content-Type": "application/json"}
        }

    # 2) require a filename
    filename = body.get("filename")
    if not filename:
        return {
            "statusCode": 400,
            "body": json.dumps({"error": "Missing 'filename' in request"}),
            "headers": {"Content-Type": "application/json"}
        }

    # 3) build your S3 key however you store it
    #    e.g. if the tar.gz is at the root of the bucket:
    key = filename
    #    or if it's under "uploads/":
    # key = f"uploads/{filename}"

    try:
        url = s3.generate_presigned_url(
            ClientMethod="get_object",
            Params={"Bucket": bucket, "Key": key},
            ExpiresIn=300
        )
        return {
            "statusCode": 200,
            "body": json.dumps({"download_url": url}),
            "headers": {"Content-Type": "application/json"}
        }

    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)}),
            "headers": {"Content-Type": "application/json"}
        }