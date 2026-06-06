//declare variable for the region
variable "aws_region" {
  description = "The AWS region to create resources in."
  type        = string
  default     = "us-east-1"
}


//declare variable for the SNS topic name
variable "aws_sns_topic_name" {
  description = "The name of the SNS topic for security alerts."
  type        = string
  default     = "SecurityScoutAlerts"
}


//declare variable for the email endpoint
variable "email_endpoint" {
  description = "The email address to receive SNS notifications."
  type        = string
  default     = "waliurrahmansun003@gmail.com"
}   