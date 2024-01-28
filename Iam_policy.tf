resource "aws_iam_policy" "ec2accesstestpolicy" {
  name = "Ec2_access_testpolicy"
  path = "/"
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": "s3:*",
			"Resource": "arn:aws:s3:::matthews-bucket-91423"
		}
	]
}
EOF
}
