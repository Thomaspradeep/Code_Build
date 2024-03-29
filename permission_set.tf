provider "aws" {
  # You should specify your AWS region here
  region = "us-east-1"
} 

resource "aws_ssoadmin_permission_set" "example" {
  name        = "test_set"
  description = "Your Permission Set Description"
  instance_arn="arn:aws:sso:::instance/ssoins-72238b70b2eebf44"
  session_duration = "PT2H"


  inline_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "VisualEditor0",
      "Effect": "Allow",
      "Action": "s3:ListAllMyBuckets",
      "Resource": "*"
    }
  ]
}
EOF

}

resource "aws_ssoadmin_account_assignment" "example" {
  instance_arn       = aws_ssoadmin_permission_set.example.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.example.arn
  principal_type     = "User"
  principal_id       = "16uma151"
  target_type        = "develop"
  target_id          = "058264506178>"
}
