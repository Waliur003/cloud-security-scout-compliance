import os
import uuid
import datetime
import boto3

s3_client = boto3.client('s3')
ec2_client = boto3.client('ec2')
dynamodb = boto3.resource('dynamodb')
sns_client = boto3.client('sns')

def lambda_handler(event, context):
    table = dynamodb.Table(os.environ['DYNAMODB_TABLE'])
    timestamp = datetime.datetime.utcnow().isoformat()
    
    # Audit 1: Check for public S3 Buckets
    buckets = s3_client.list_buckets()['Buckets']
    for bucket in buckets:
        name = bucket['Name']
        try:
            pab = s3_client.get_bucket_public_access_block(Bucket=name)
            configs = pab['PublicAccessBlockConfiguration']
            if not all(configs.values()):
                flag_finding(table, "S3_PUBLIC_ACCESS_DRIFT", name, timestamp)
        except:
            # No Public Access Block configured means it's a structural vulnerability!
            flag_finding(table, "S3_NO_PUBLIC_ACCESS_BLOCK", name, timestamp)
            
    # Audit 2: Check for Unrestricted Security Group Ports (e.g., Port 22 Open to World)
    sgs = ec2_client.describe_security_groups()['SecurityGroups']
    for sg in sgs:
        for perm in sg.get('IpPermissions', []):
            for ip_range in perm.get('IpRanges', []):
                if ip_range.get('CidrIp') == '0.0.0.0/0' and perm.get('ToPort') in [22, 3389]:
                    flag_finding(table, "EC2_OPEN_MANAGEMENT_PORT", sg['GroupId'], timestamp)

def flag_finding(table, type, resource, timestamp):
    finding_id = str(uuid.uuid4())
    table.put_item(Item={'FindingID': finding_id, 'Timestamp': timestamp, 'Type': type, 'ResourceID': resource, 'Status': 'ACTIVE'})
    sns_client.publish(TopicArn=os.environ['SNS_TOPIC_ARN'], Subject=f"CRITICAL DRIFT: {type}", Message=f"Resource {resource} violated security baseline at {timestamp}.")