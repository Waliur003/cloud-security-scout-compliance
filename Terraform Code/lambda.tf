//create a Lambda function named "cloud-security-scout"
resource "aws_lambda_function" "cloud_security_scout" {
  function_name = "cloud-security-scout"
  role          = aws_iam_role.SecurityScoutLambdaRole.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.12"
  architectures = ["x86_64"]

  //Assuming the Lambda code is in a file named "lambda_function.zip" in the same directory
  filename      = "lambda_function.zip"

  //Environment variables for the Lambda function
  environment {
    variables = {
      SNS_TOPIC_ARN   = aws_sns_topic.security_scout_alerts.arn
      DYNAMODB_TABLE  = aws_dynamodb_table.security_scout_findings.name
    }
  }

  tags = {
    Environment = "Production"
    Project     = "Security Scout"
  }
}