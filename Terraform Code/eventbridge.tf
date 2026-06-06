//Create EventBridge rule named "SecurityScoutSchedule" to trigger Lambda function on a schedule at cron expression "0 2 * * ? *" (2 AM UTC daily)
resource "aws_cloudwatch_event_rule" "SecurityScoutSchedule" {
  name                = "SecurityScoutSchedule"
  description         = "Triggers the Security Scout Lambda function daily at 2 AM UTC"
  schedule_expression = "cron(0 2 * * ? *)"

  tags = {
    Environment = "Production"
    Project     = "Security Scout"
  }
}

//Create EventBridge target to link the rule to the Lambda function
resource "aws_cloudwatch_event_target" "SecurityScoutLambdaTarget" {
  rule      = aws_cloudwatch_event_rule.SecurityScoutSchedule.name
  target_id = "SecurityScoutLambdaTarget"
  arn       = aws_lambda_function.cloud_security_scout.arn
}

//Grant EventBridge permission to invoke the Lambda function
resource "aws_lambda_permission" "AllowEventBridgeInvoke" {
  statement_id  = "AllowEventBridgeInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.cloud_security_scout.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.SecurityScoutSchedule.arn
}