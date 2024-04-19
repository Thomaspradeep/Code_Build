data "aws_s3_bucket" "matthew_bucket_main"{
    bucket = "matthew-bucket-91423"
}

resource "aws_s3_bucket" "glue_bucket_matthew" {
    bucket = "glue-bucket-matthew"
    versioning{
        enabled = true
    }
     tags = {
         Env = "Terraform"
     }
     logging{
        target_bucket = data.aws_s3_bucket.matthew_bucket_main
        target_prefix = "Logs/"
    }
 }

 # Objects Modules
module "glue_bucket_matthew"{
     for_each = var.clients_list
     source = "./modules/client_bucket_directories"
    
     bucket_id = aws_s3_bucket.glue_bucket_matthew.id
     client_name = each.key
 }

resource "aws_s3_bucket_policy" "glue_bucket_matthew"{
    bucket = aws_s3_bucket.glue_bucket_matthew.id
    policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
			"Sid": "InventoryAndAnalyticsExamplePolicy",
			"Effect": "Allow",
			"Principal": {
				"Service": "s3.amazonaws.com"
			},
			"Action": "s3:PutObject",
			"Resource": "arn:aws:s3:::glue-bucket-matthew/*",
			"Condition": {
				"StringEquals": {
					"aws:SourceAccount": "941598205732",
					"s3:x-amz-acl": "bucket-owner-full-control"
				},
				"ArnLike": {
					"aws:SourceArn": "arn:aws:s3:::matthew-bucket-91423"
				}
			}
		}
    ]
}
EOF
}



 
# resource "aws_s3_bucket" "aws_glue_databucket"{
#     bucket = join("-", ["aws","glue","data","bucket"])
#     versioning{
#         enabled = true
#     }
#     tags = {
#         env = "Glue"
#     }
#     logging {
#         target_bucket = aws_s3_bucket.log_bucket.id
#         target_prefix = "Log/land_bucket"
#     }
# }
