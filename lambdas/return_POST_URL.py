import boto3
import os
import json
import mimetypes

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

    # 2) require a filename (this can include folders/prefixes)
    filename = body.get("filename")
    if not filename or not isinstance(filename, str):
        return {
            "statusCode": 400,
            "body": json.dumps({"error": "Missing or invalid 'filename' in request"}),
            "headers": {"Content-Type": "application/json"}
        }

    # 3) determine content type from extension
    ext = os.path.splitext(filename)[1].lower()
    if ext == ".json":
        content_type = "application/json"
    else:
        content_type = mimetypes.guess_type(filename)[0] or "application/octet-stream"

    # 4) generate a presigned POST for exactly the key they supplied
    try:
        presigned_post = s3.generate_presigned_post(
            Bucket=bucket,
            Key=filename,
            Fields={"Content-Type": content_type},
            Conditions=[
                {"content-type": content_type},
                ["content-length-range", 1, 1024*1024*1024]  # up to 1 GB
            ],
            ExpiresIn=300
        )
    except Exception as e:
        return {
            "statusCode": 500,
            "body": json.dumps({"error": str(e)}),
            "headers": {"Content-Type": "application/json"}
        }

    return {
        "statusCode": 200,
        "body": json.dumps(presigned_post),
        "headers": {"Content-Type": "application/json"}
    }