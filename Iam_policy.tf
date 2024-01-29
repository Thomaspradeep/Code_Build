resource "aws_iam_policy" "ec2accesstestpolicy" {
  name = "Ec2_access_testpolicy"
  path = "/"
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "Allows3BucketAccess",
			"Effect": "Allow",
			"Action": [
                "s3:ListAllMyBuckets"
                ],
			"Resource": "*"
		},
    {
			"Sid": "AllowBucketaccess",
			"Effect": "Allow",
			"Action": [
                "s3:PutObject*",
                "s3:GetObject*",
                "s3:DeleteObject*",
                "s3:List*"
                ],
			"Resource": [
                "arn:aws:s3:::matthews-bucket-91423",
                "arn:aws:s3:::matthews-bucket-91423/*"
                ]
		},
    {
      "Sid": "AllowIAMAccess",
      "Effect": "Allow",
      "Action": "iam:*",
      "Resource": "*"
    }
	]
}
EOF
}
