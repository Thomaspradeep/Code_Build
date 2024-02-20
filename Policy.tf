resource "aws_iam_policy" "business_analyst_basic_user_policy"{
  name        = "DDM_Custom_Business_Analyst"
  description = "A basic business analyst access user"
  path        = "/"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ABACClientEncryptionKeyAccess",
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt",
                "kms:Encrypt",
                "kms:DescribeKey",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*"
            ],
            "Resource": "arn:aws:kms:${var.aws_region}:${var.aws_account}:key/*",
            "Condition": {
                "StringEqualsIgnoreCase": {
                    "aws:PrincipalTag/ClientName": "$${aws:ResourceTag/ClientName}"
                }
            }
        },
        {
            "Sid": "AllowEventBridgeAccess",
            "Effect": "Allow",
            "Action": [
                "events:DescribeRule",
                "events:DisableRule",
                "events:EnableRule",
                "events:PutRule",
                "events:List*"
            ],
            "Resource": "*"
        },
        {
            "Sid": "DenyClientBucketAccess",
            "Effect": "Deny",
            "Action": "s3:*",
            "Resource": [
                "log_bucket",
                "client_process_bucket",
                "client_land_bucket",
                "data_gateway_client_bucket"
            ],
                "Condition": {
                    "StringLike": {
                        "aws:PrincipalArn": [
                            "arn:aws:iam::${var.aws_account}:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_ddm_${var.environment}_businessanalyst_*"
                        ]
                    }
                }
        },
        {
            "Sid": "AllowReadOnlyVendorBucketAccess",
            "Effect": "Allow",
             "Action": [
                "s3:List*",
                "S3:GetObject"
            ],
            "Resource": [
                "consume_bucket",
                "process_bucket",
                "land_bucket",
                "s3_consume_bucket",
                "s3_process_bucket",
                "s3_land_bucket",
                "first_american_vendor",
                "data_gateway_bucket",
                "data_gateway_vendor_bucket",
                "consume_bucket/*",
                "process_bucket/*",
                "land_bucket/*",
                "s3_consume_bucket/*",
                "s3_process_bucket/*",
                "s3_land_bucket/*",
                "first_american_vendor/*",
                "data_gateway_bucket/*",
                "data_gateway_vendor_bucket/*"
            ]
        },

        {
            "Sid": "AllowDataAnalystBucketAccess",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "data_analyst_bucket",
                "data_analyst_bucket/*",
                "entity_config_bucket",
                "entity_config_bucket/*",
                "nxgen_airflow_bucket/dags/*"
            ]
        },

        {
            "Sid": "AllowListAccess",
            "Effect": "Allow",
            "Action": "s3:List*",
            "Resource": [
                "nxgen_airflow_bucket"
            ]
        },
        {
            "Sid": "AllowAthenaBucketAccess",
            "Effect": "Allow",
            "Action": [
                "s3:List*",
                "S3:GetObject"
            ],
            "Resource": [                
                "athena_results_bucket",          
                "s3_athena_results_bucket",            
                "athena_results_bucket/*",
                "s3_athena_results_bucket/*"                
            ]
        },

        {
            "Sid": "AllowGlueBucketAccess",
            "Effect": "Allow",
            "Action": [
                "s3:Put*",
                "s3:Get*",
                "s3:List*",
                "s3:Delete*"
            ],
            "Resource": [
                "arn:aws:s3:::*glue*"
            ]
        },
        {
            "Sid": "DenyDataScienceS3Buckets",
            "Effect": "Deny",
            "Action": [
                "s3:Abort*",
                "s3:DeleteObject*",
                "s3:Get*",
                "s3:Put*",
                "s3:List*"
            ],
            "Resource": [
                "arn:aws:s3:::*datascience*",
                "arn:aws:s3:::*datascience-*",
                "arn:aws:s3:::*datascience"
            ]
        },
        {
            "Sid": "ABACClientFolderListAccess",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucketMultipartUploads",
                "s3:ListBucketVersions",
                "s3:ListBucket",
                "s3:ListMultipartUploadParts",
                "s3:GetBucketVersioning"
            ],
            "Resource": [
                "log_bucket"
            ],
            "Condition": {
                "StringLike": {
                    "s3:Prefix": [
                        "$${aws:PrincipalTag/ClientName}",
                        "$${aws:PrincipalTag/ClientName}/*"
                    ]
                }
            }
        },
        {
            "Sid": "ABACPutDeleteAccessToClientProcessFolder",
            "Action": [
                "s3:Put*",
                "s3:Get*",
                "s3:List*",
                "s3:Delete*"
            ],
            "Effect": "Allow",
            "Resource": [
                "${aws_s3_bucket.log_bucket.arn}/$${aws:PrincipalTag/ClientName}/*"
            ],
            "Condition": {
                "StringLike": {
                    "s3:Prefix": [
                        "$${aws:PrincipalTag/ClientName}/*Process",
                        "$${aws:PrincipalTag/ClientName}/*Process/*"
                    ]
                }
            }
        },
        {
            "Sid": "ABACGetAccessToClientProcessFolder",
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:ListBucket"
            ],
            "Resource": [
                "${aws_s3_bucket.log_bucket.arn}/$${aws:PrincipalTag/ClientName}/*"
            ]
        },
        {
            "Sid": "AllowUserToSeeBucketListInTheConsole",
            "Action": [
                "s3:ListAllMyBuckets",
                "s3:GetAccountPublicAccessBlock",
                "s3:GetBucketPublicAccessBlock",
                "s3:GetBucketPolicyStatus",
                "s3:GetBucketAcl",
                "s3:ListAccessPoints",
                "s3:GetBucketVersioning"
            ],
            "Effect": "Allow",
            "Resource": "*"
        },
        {
            "Sid": "AllowRootAndListingOfClientConsumeBucket",
            "Action": [
                "s3:ListBucket"
            ],
            "Effect": "Allow",
            "Resource": [
                "${aws_s3_bucket.log_bucket.arn}"
            ],
            "Condition": {
                "StringEquals": {
                    "s3:prefix": [
                        ""
                    ],
                    "s3:delimiter": [
                        "/"
                    ]
                }
            }
        },
        {
            "Sid": "DenyGlueStartStop",
            "Effect": "Deny",
            "Action": [
                "glue:StartJobRun",
                "glue:StopTrigger",
                "glue:BatchStopJobRun",
                "glue:StartTrigger"
            ],
            "Resource": "*",
            "Condition": {
                "ForAnyValue:StringNotEquals": {
                    "aws:ResourceTag/Team": [
                        "Business Analysts",
                        "Data Engineering"
                    ]
                }
            }
        },
        {
            "Sid": "DenyGlueCreateDelete",
            "Effect": "Deny",
            "Action": [
                "glue:UpdateTrigger",
                "glue:UpdateJob",
                "glue:DeleteTrigger",
                "glue:DeleteJob"
            ],
            "Resource": "*",
            "Condition": {
                "StringNotEquals": {
                    "aws:ResourceTag/Team": "Business Analysts"
                }
            }
        },
        {
            "Sid": "DenyIAMSecretsManagerAssume",
            "Effect": "Deny",
            "Action": [
                "iam:GetRole",
                "iam:UpdateAssumeRolePolicy",
                "iam:PassRole"
            ],
            "Resource": [
                "arn:aws:iam::${var.aws_account}:role/AWSGlueServiceRole_${var.environment}_tf_secrets",
                "arn:aws:iam::${var.aws_account}:role/AWSLambdaGlueRole_${var.environment}_secrets"
            ]
        },
        {
            "Sid": "DenyIAMSecretsManagerAssumeList",
            "Effect": "Deny",
            "Action": "iam:ListRoles",
            "Resource": [
                "arn:aws:iam::${var.aws_account}:role/AWSGlueServiceRole_${var.environment}_tf_secrets",
                "arn:aws:iam::${var.aws_account}:role/AWSLambdaGlueRole_${var.environment}_secrets"
            ]
        },
        {
            "Sid": "DenyGlueStartStop",
            "Effect": "Deny",
            "Action": [
                "glue:StartJobRun",
                "glue:StopTrigger",
                "glue:BatchStopJobRun",
                "glue:StartTrigger"
            ],
            "Resource": "*",
            "Condition": {
                "ForAnyValue:StringNotEquals": {
                    "aws:ResourceTag/Team": [
                        "Business Analysts",
                        "Data Engineering"
                    ]
                }
            }
        },
        {
            "Sid": "DenyGlueCreateDelete",
            "Effect": "Deny",
            "Action": [
                "glue:UpdateTrigger",
                "glue:UpdateJob",
                "glue:DeleteTrigger",
                "glue:DeleteJob"
            ],
            "Resource": "*",
            "Condition": {
                "StringNotEquals": {
                    "aws:ResourceTag/Team": "Business Analysts"
                }
            }
        },
        {
            "Sid": "DenyIAMSecretsManagerAssume",
            "Effect": "Deny",
            "Action": [
                "iam:GetRole",
                "iam:UpdateAssumeRolePolicy",
                "iam:PassRole"
            ],
            "Resource": [
                "arn:aws:iam::${var.aws_account}:role/AWSGlueServiceRole_${var.environment}_tf_secrets",
                "arn:aws:iam::${var.aws_account}:role/AWSLambdaGlueRole_${var.environment}_secrets"
            ]
        },
        {
            "Sid": "DenyIAMSecretsManagerAssumeList",
            "Effect": "Deny",
            "Action": "iam:ListRoles",
            "Resource": [
                "arn:aws:iam::${var.aws_account}:role/AWSGlueServiceRole_${var.environment}_tf_secrets",
                "arn:aws:iam::${var.aws_account}:role/AWSLambdaGlueRole_${var.environment}_secrets"
                ]
        }
    ]
}
EOF
}
