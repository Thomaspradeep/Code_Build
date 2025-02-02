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
          "aws:PrincipalArn": "arn:aws:iam::${var.aws_account}:user/1685163"
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
  name = "BusinessAnalystPolicy"
  description = "Version 1 BA General secretmanager policy"
  path = "/"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowSecretsManagerActions",
      "Effect": "Deny",
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
        "StringNotEquals": {
          "secretsmanager:ResourceTag/Team": [
            "Business Analyst"
          ]
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


resource "aws_iam_policy" "ba_Seceretmanagerpolicy"{
  name = "BA_secretsmanager_policy"
  description = "Version 2 BA general secretmanager policy"
  path = "/"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowSecretsManagerActions",
      "Effect": "Allow",
      "Action": [
        "secretsmanager:DescribeSecret",
        "secretsmanager:PutSecretValue",
        "secretsmanager:UpdateSecret",
        "secretsmanager:RestoreSecret",
        "secretsmanager:Get*",
        "secretsmanager:TagResource",
        "secretsmanager:CreateSecret"
      ],
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "secretsmanager:ResourceTag/Team": "Business Analyst"
        },
        "Null": {
          "secretsmanager:ResourceTag/Entity": "true"
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
    },
    {
      "Sid": "KMSfullaccess",
      "Effect": "Allow",
      "Action": "kms:*",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "User_Assume_Role"{
  name = "User_Switch_Role"
  description = "User Switch role access"
  path = "/"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Resource": [
          "arn:aws:iam::${var.aws_account}:role/Business_analyst_role",
          "arn:aws:iam::${var.aws_account}:role/Ktk_client_role"
      ]
    }
  ]
}
EOF
}