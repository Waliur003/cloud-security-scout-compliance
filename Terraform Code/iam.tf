//Create IAM policy document for Security Scout
data "aws_iam_policy_document" "SecurityScoutExecutionPolicy" {
  statement {
    sid    = "ConfigurationAuditing"
    effect = "Allow"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketPublicAccessBlock",
      "ec2:DescribeSecurityGroups",
    ]

    resources = ["*"]
  }

  statement {
    sid    = "LoggingAndAlerting"
    effect = "Allow"

    actions = [
      "dynamodb:PutItem",
      "sns:Publish",
    ]

    resources = ["*"]
  }
}


//Create the IAM policy using the above document
resource "aws_iam_policy" "security_scout_policy" {
  name        = "SecurityScoutExecutionPolicy"
  description = "Read-only cloud configuration metadata parsing and alerting policy"
  policy      = data.aws_iam_policy_document.SecurityScoutExecutionPolicy.json
}


//attach your SecurityScoutExecutionPolicy along with the default AWS-managed policy AWSLambdaBasicExecutionRole (for CloudWatch logging logs). Name the role SecurityScoutLambdaRole and finalize creation
resource "aws_iam_role" "SecurityScoutLambdaRole" {
  name = "SecurityScoutLambdaRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}


//Attach the custom policy to the role
resource "aws_iam_role_policy_attachment" "SecurityScoutExecutionPolicyAttachment" {
  role       = aws_iam_role.SecurityScoutLambdaRole.name
  policy_arn = aws_iam_policy.security_scout_policy.arn
}

//Attach the AWS-managed policy for Lambda basic execution
resource "aws_iam_role_policy_attachment" "AWSLambdaBasicExecutionRoleAttachment" {
  role       = aws_iam_role.SecurityScoutLambdaRole.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


