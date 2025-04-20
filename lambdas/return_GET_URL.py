import boto3
import os
import json

def get_cross_account_s3_client():
    # First assume the cross-account role
    sts_client = boto3.client('sts')
    
    # Get the role ARN from environment variable
    artifact_role_arn = os.environ.get("CROSS_ACCOUNT_ROLE_ARN")
    
    if artifact_role_arn:
        try:
            # Assume the role in the artifact account
            assumed_role = sts_client.assume_role(
                RoleArn=artifact_role_arn,
                RoleSessionName="LambdaCrossAccountModelAccess"
            )
            
            # Create an S3 client using the temporary credentials from the assumed role
            s3 = boto3.client(
                "s3",
                region_name=os.environ.get("AWS_REGION", "us-west-2"),
                aws_access_key_id=assumed_role['Credentials']['AccessKeyId'],
                aws_secret_access_key=assumed_role['Credentials']['SecretAccessKey'],
                aws_session_token=assumed_role['Credentials']['SessionToken']
            )
            return s3
        except Exception as e:
            print(f"Error assuming role: {str(e)}")
            
    # Fall back to default credentials if role assumption fails or no role ARN provided
    return boto3.client("s3")

# Get properly configured S3 client that can access cross-account resources
s3 = get_cross_account_s3_client()
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
            "body": json.dumps({"error": str(e)}),
            "headers": {"Content-Type": "application/json"}
        }