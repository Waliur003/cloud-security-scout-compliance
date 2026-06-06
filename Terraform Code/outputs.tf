//Output the ARN of the created IAM role for use in other resources
output "SecurityScoutLambdaRoleARN" {
  value = aws_iam_role.SecurityScoutLambdaRole.arn
}

//Output the ARN of the created SNS topic for use in other resources
output "SecurityScoutSNSTopicARN" {
  value = aws_sns_topic.security_scout_alerts.arn
}

//Output the name of the created DynamoDB table for use in other resources
output "SecurityScoutDynamoDBTableName" {
  value = aws_dynamodb_table.security_scout_findings.name
}

//Output the AWS region being used for resource creation
output "AWSRegion" {
  value = var.aws_region
}

//Output the email endpoint for SNS notifications
output "EmailEndpoint" {
  value = var.email_endpoint
}

//output of the lambda arn for use in other resources
output "CloudSecurityScoutLambdaARN" {
  value = aws_lambda_function.cloud_security_scout.arn
}