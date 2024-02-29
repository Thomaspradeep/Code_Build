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
        "secretsmanager:UntagResoruce",
        "secretsmanager:DescribeSecret",
        "secretsmanager:DeleteResourcePolicy",
        "secretsmanager:PutSecretValue",
        "secretsmanager:DeleteSecret",
        "secretsmanager:CancelRotateSecret",
        "secretsmanager:ListSecretVersionIds",
        "secretsmanager:UpdateSecret",
        "secretsmanager:GetRandomPassword",
        "secretsmanager:GetResourcePolicy",
        "secretsmanager:GetSecretValue",
        "secretsmanager:StopReplicationToReplica",
        "secretsmanager:PutResourcePolicy",
        "secretsmanager:ReplicateSecretToRegions",
        "secretsmanager:RestoreSecret",
        "secretsmanager:UpdateSecretVersionStage",
        "secretsmanager:RotateSecret",
        "secretsmanager:ValidateResourcePolicy",
        "secretsmanager:RemoveRegionsFromReplication"
      ],
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "secretsmanager:ResourceTag/Team": "Business Analyst"
        }
      }
    },
    {
      "Sid": "AllowSecretmanagerListAccess",
      "Effect": "Allow",
      "Action": [
        "secretsmanager:List*",
        "secretsmanager:BatchGetSecretValue"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "Userbasedpolicy"{
  name = "client1"
  description = "creating for particular user"
  path = "/"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ClientSecretmanagerAccess",
      "Effect": "Allow",
      "Action": [
        "secretmanager:DescribeSecret",
        "secretmanager:Get*",
        "secretmanager:PutSecretValue",
        "secretmanager:CreateSecret",
        "secretmanager:RestoreSecret",
        "secretmanager:TagResource",
        "secretmanager:UpdateSecret"
      ],
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "aws:ResourceTag/Team": "Business Analyst",
          "aws:ResourceTag/Entity": "tom"
        }
      }
    }
  ]
}
EOF
}