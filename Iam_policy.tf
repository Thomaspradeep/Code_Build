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
			"Action": [
				"s3:Get*,
				"s3:Describe*",
				"s3:List*"
			],
			"Resource": "arn:aws:s3::: matthews-bucket-91423"
		},
		{
			"Sid": "VisualEditor1",
			"Effect": "Allow",
			"Action": [
				"s3:ListStorageLensConfigurations",
				"s3:ListAccessPointsForObjectLambda",
				"s3:GetAccessPoint",
				"s3:GetAccountPublicAccessBlock",
				"s3:ListAllMyBuckets",
				"s3:ListAccessPoints",
				"s3:ListAccessGrantsInstances",
				"s3:ListJobs",
				"s3:ListMultiRegionAccessPoints",
				"s3:ListStorageLensGroups"
			],
			"Resource": "*"
		}
	]
}
EOF
}
