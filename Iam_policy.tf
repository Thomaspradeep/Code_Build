resource "aws_iam_policy" "ec2accesstestpolicy" {
  name = "Ec2_access_testpolicy"
  path = "/"
  policy = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
        {
            "Sid": "S3bucket",
            "Effect": "Allow",
            "Action": "s3:*",
            "Allow": "*",
            "Resource": "*"
        },
		{
			"Sid": "VisualEditor0",
			"Effect": "Allow",
			"Action": [
				"s3:GetBucketTagging",
				"s3:DeleteObjectVersion",
				"s3:GetObjectVersionTagging",
				"s3:GetBucketLogging",
				"s3:GetObjectVersionAttributes",
				"s3:GetBucketPolicy",
				"s3:GetStorageLensConfigurationTagging",
				"s3:GetObjectVersionTorrent",
				"s3:GetObjectAcl",
				"s3:GetBucketObjectLockConfiguration",
				"s3:GetBucketRequestPayment",
				"s3:GetObjectVersionAcl",
				"s3:GetObjectTagging",
				"s3:GetBucketOwnershipControls",
				"s3:DeleteObject",
				"s3:GetBucketPublicAccessBlock",
				"s3:GetBucketPolicyStatus",
				"s3:GetObjectRetention",
				"s3:GetBucketWebsite",
				"s3:GetObjectAttributes",
				"s3:PutObjectLegalHold",
				"s3:GetBucketVersioning",
				"s3:GetBucketAcl",
				"s3:GetObjectLegalHold",
				"s3:GetBucketNotification",
				"s3:PutObject",
				"s3:GetObject",
				"s3:GetObjectTorrent",
				"s3:PutObjectRetention",
				"s3:GetBucketCORS",
				"s3:GetObjectVersionForReplication",
				"s3:GetBucketLocation",
				"s3:GetObjectVersion"
			],
			"Resource": "arn:aws:s3:::arn:aws:s3:::matthews-bucket-91423"
		}
	]
}
EOF
}
