resource "aws_iam_policy" "business_analyst_basic_user_policy" {
  name        = "DDM_Custom_Business_Analyst"
  description = "A basic business analyst access user"
  path        = "/"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {   "Sid": "ABACClientEncryptionKeyAccess",
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
        {   "Sid": "S3ServiceEncryptionKeyAccess",
            "Effect": "Allow",
            "Action": [
                "kms:Decrypt",
                "kms:Encrypt",
                "kms:DescribeKey",
                "kms:ReEncrypt*",
                "kms:GenerateDataKey*"
            ],
            "Resource": [
                "${module.d3_services["s3"].primary_arn}",
                "${module.d3_services["athena"].primary_arn}",
                "${var.athena_key_arn}"
            ]
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
                "${aws_s3_bucket.client_consume_bucket.arn}",
                "${aws_s3_bucket.client_process_bucket.arn}",
                "${aws_s3_bucket.client_land_bucket.arn}",
                "${aws_s3_bucket.data_gateway_client_bucket.arn}"
            ],
                "Condition": {
                    "StringLike": {
                        "aws:PrincipalArn": [
                            "arn:aws:iam::${var.aws_account}:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_ddm_${var.iam_environment}_businessanalyst_*",
                            "arn:aws:iam::${var.aws_account}:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_ddm_${var.environment}_businessanalyst_*"
                        ]
                    }
                }
        },
        {
            "Sid": "AllowReadOnlyVendorAndAthenaBucketAccess",
            "Effect": "Allow",
             "Action": [
                "s3:List*",
                "S3:GetObject"
            ],
            "Resource": [
                "${aws_s3_bucket.consume_bucket.arn}",
                "${aws_s3_bucket.process_bucket.arn}",
                "${aws_s3_bucket.land_bucket.arn}",
                "${aws_s3_bucket.first_american_vendor.arn}",
                "${aws_s3_bucket.data_gateway_bucket.arn}",
                "${aws_s3_bucket.data_gateway_vendor_bucket.arn}",
                "${aws_s3_bucket.consume_bucket.arn}/*",
                "${aws_s3_bucket.process_bucket.arn}/*",
                "${aws_s3_bucket.land_bucket.arn}/*",
                "${aws_s3_bucket.first_american_vendor.arn}/*",
                "${aws_s3_bucket.data_gateway_bucket.arn}/*",
                "${aws_s3_bucket.data_gateway_vendor_bucket.arn}/*",
                "${aws_s3_bucket.s3_ddm_land_bucket.arn}",
                "${aws_s3_bucket.s3_ddm_land_bucket.arn}/*",
                "${aws_s3_bucket.s3_consume_ddm_bucket.arn}",
                "${aws_s3_bucket.s3_consume_ddm_bucket.arn}/*",
                "${aws_s3_bucket.s3_process_ddm_bucket.arn}",
                "${aws_s3_bucket.s3_process_ddm_bucket.arn}/*",
                "${aws_s3_bucket.athena_results_bucket.arn}",
                "${aws_s3_bucket.s3_athena_results_bucket.arn}",
                "${aws_s3_bucket.athena_results_bucket.arn}/*",
                "${aws_s3_bucket.s3_athena_results_bucket.arn}/*"
            ]
        },
        {
            "Sid": "AllowDataAnalystBucketAccess",
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "${aws_s3_bucket.data_analyst_bucket.arn}",
                "${aws_s3_bucket.data_analyst_bucket.arn}/*",
                "${aws_s3_bucket.entity_config_bucket.arn}",
                "${aws_s3_bucket.entity_config_bucket.arn}/*",
                "${aws_s3_bucket.nxgen_airflow_bucket.arn}/dags/*",
                "${aws_s3_bucket.client_audit_bucket.arn}",
                "${aws_s3_bucket.client_audit_bucket.arn}/*"
            ]
        },
        {
            "Sid": "AllowListAccess",
            "Effect": "Allow",
            "Action": "s3:List*",
            "Resource": [
                "${aws_s3_bucket.nxgen_airflow_bucket.arn}"
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
                "${aws_s3_bucket.client_consume_bucket.arn}"
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
                "${aws_s3_bucket.client_consume_bucket.arn}/$${aws:PrincipalTag/ClientName}/*"
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
                "${aws_s3_bucket.client_consume_bucket.arn}/$${aws:PrincipalTag/ClientName}/*"
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
                "${aws_s3_bucket.client_consume_bucket.arn}"
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
        }
    ]
}
EOF
}
