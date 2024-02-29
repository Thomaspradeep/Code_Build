resource "aws_iam_policy" "ec2accesstestpolicy1" {
  name = "Ec2_access_testpolicy1"
  description = "Created for testing purpose"
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
                "arn:aws:s3:::mumbai-kms-demo-bucket",
                "arn:aws:s3:::mumbai-kms-demo-bucket/*"
                ]
		},
    {
      "Sid": "AllowIAMAccess",
      "Effect": "Allow",
      "Action": "iam:*",
      "Resource": "*",
      "Condition":{
        "StringEquals":{
          "aws:PrincipalArn": "arn:aws:iam::941598205732:user/1685163"
        }
      }
    }
	]
}
EOF
}

resource "aws_iam_policy" "ec2accesstestpolicyVicky" {
  name = "Ec2_access_testpolicy_Vicky"
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
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:PutObject",
                "s3:PutObjectAcl"
            ],
            "Resource": [
                "arn:aws:s3:::createtestbucket",
                "arn:aws:s3:::createtestbucket/*"
            ]
    }
    ] 
}
EOF
}

resource "aws_iam_policy" "EventBridge"{
    name = "Test-EventBridge-Policy"
    description = "Creation this policy for testing purpose"
    path = "/"
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "EventBridge",
            "Effect": "Allow",
            "Action": [
                "events:DescribeRule",
                "events:DisableRule",
                "events:PutRule",
                "events:List*",
                "events:EnableRule"
            ],
            "Resource":"*"
        }
    ]
}
EOF
}

resource "aws_iam_policy" "Seceretmanagerpolicy"{
  name = "hdfcbankpolicy"
  description = "created for HDFC bank secretmanager policy"
  path = "/"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowSecretsManagerActions",
      "Effect": "Allow",
      "Action": [
        "secretmanager:UntagResoruce",
        "secretmanager:DescribeSecret",
        "secretmanager:DeleteResourcePolicy",
        "secretmanager:PutSecretValue",
        "secretmanager:DeleteSecret",
        "secretmanager:CancelRotateSecret",
        "secretmanager:ListSecretVersionIds",
        "secretmanager:UpdateSecret",
        "secretmanager:GetRandomPassword",
        "secretmanager:GetResourcePolicy",
        "secretmanager:GetSecretValue",
        "secretmanager:StopReplicationToReplica",
        "secretmanager:PutResourcePolicy",
        "secretmanager:ReplicateSecretToRegions",
        "secretmanager:RestoreSecret",
        "secretmanager:UpdateSecretVersionStage",
        "secretmanager:RotateSecret",
        "secretmanager:ValidateResourcePolicy",
        "secretmanager:RemoveRegionsFromReplication"
      ],
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "secretsmanager:ResourceTag/Team": "Business Analyst"
        }
      }
    }
  ]
}
EOF
}