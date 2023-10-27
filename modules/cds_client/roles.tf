resource "aws_iam_policy" "business_analyst_credit" {
    count = local.iam_map.create_roles ? 1 : 0
    name = "DDM_Custom_Business_Analyst_credit_${var.client_name}"
    description = "Business analyst client Access Policy - ${var.client_name}"
    path = "/"
    policy =  <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "sid" : "DenyClientBucketAccess".
                "Effect": "Allow",
                "Action": "s3:*",
                "Resource" : "*" 
            }
        ]
    }
    EOF
}
