//Create SNS topic named "SecurityScoutAlerts"
resource "aws_sns_topic" "security_scout_alerts" {
  name = var.aws_sns_topic_name

  tags = {
    Environment = "Production"
    Project     = "Security Scout"
  }
}


//Create Email Subscriptiom
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.security_scout_alerts.arn
  protocol  = "email"
  endpoint  = var.email_endpoint
  
}
