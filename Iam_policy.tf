resource "aws_iam_policy" "ec2accesstestpolicy" {
  name = "Ec2_access_testpolicy"
  path = "/"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "S3ListBucketAccess",
            "Effect": "Allow",
            "Action": "s3:ListBucket",
            "Resource" : "*"
        }
    ]
}
EOF
}
