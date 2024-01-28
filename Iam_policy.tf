resource "aws_iam_policy" "ec2accesstestpolicy" {
  name = "Ec2_access_testpolicy"
  path = "/"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "DenyEc2access",
            "Effect": "Deny",
            "Action": "ec2:*",
            "Resource": "*"
        },
        {
            "Sid": "AllowReadAccess",
            "Effect": "Allow",
            "Action": [
                "ec2:Describe*",
                "ec2:Get*",
                "ec2:Export*"
            ],
            "Resource" : "*"
        }
    ]
}
EOF
}
