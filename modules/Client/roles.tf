resource "aws_iam_policy" "Userbasedpolicy"{
  name = "Client_policy_${var.client_name}"
  description = "created policy for user ${var.client_name}"
  path = "/"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ClientSecretmanagerAccess",
      "Effect": "Allow",
      "Action": [
        "secretsmanager:DescribeSecret",
        "secretsmanager:Get*",
        "secretsmanager:PutSecretValue",
        "secretsmanager:CreateSecret",
        "secretsmanager:RestoreSecret",
        "secretsmanager:TagResource",
        "secretsmanager:UpdateSecret"
      ],
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "secretsmanager:ResourceTag/Entity": [
            "${var.client_name}"
          ],
          "secretsmanager:ResourceTag/Team": [
            "Business Analyst"
          ]
        }
      }
    }
  ]
}
EOF
}
