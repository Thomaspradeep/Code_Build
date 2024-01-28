resource "aws_iam_policy" "ec2accesstestpolicy" {
  name = "Ec2_access_testpolicy"
  path = "/"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:ListBucket"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::matthews-bucket-91423"
    },
    {
      "Action": [
        "s3:DeleteObject",
        "s3:GetObject",
        "s3:PutObject",
        "s3:PutObjectAcl"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:s3:::matthews-bucket-91423/*"
    }
  ]
}
EOF
}
