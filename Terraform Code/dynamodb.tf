//create a DynamoDB table named "security-scout-findings"
resource "aws_dynamodb_table" "security_scout_findings" {
  name           = "security-scout-findings"
  billing_mode   = "ON_DEMAND"
  hash_key       = "FindingID"
  range_key = "Timestamp"

  attribute {
    name = "FindingID"
    type = "S"
  }

  //Another attribute for the timestamp of the finding
  attribute {
    name = "Timestamp"
    type = "S"
  }

  tags = {
    Environment = "Production"
    Project     = "Security_Scout"
  }
}
