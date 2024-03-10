resource "aws_s3_bucket" "log_bucket" {
    bucket = "log-${var.bucket_name}"
   versioning{
    enabled = true
   }
    tags = {
        Env = "Dev"
    }
}

resource "aws_s3_bucket" "CDS_Infra_bucket" {
    bucket = var.bucket_name
    logging{
        target_bucket = aws_s3_bucket.log_bucket.id
        target_prefix = "Log/land_bucket"
    }

   versioning{
    enabled = true
   }
    tags = {
        Env = "Dev"
    }
}

resource "aws_s3_bucket_object" "log_bucket"{
    bucket = aws_s3_bucket.log_bucket.id
    key = "Log/land_bucket"
}

resource "aws_s3_bucket" "glue_bucket_matthew" {
    bucket = "glue-bucket-matthew01"
   versioning{
    enabled = true
   }
    tags = {
        Env = "Dev"
    }
}
resource "aws_s3_bucket" "deeran_bucket" {
    bucket = var.deeran
   versioning{
    enabled = true
   }
    tags = {
        Env = "Dev"
    }
}
module "glue_bucket_matthew"{
     for_each = var.my_clients
     source = "./modules/client_bucket_directories"
    
     bucket_id = aws_s3_bucket.glue_bucket_matthew.id
     client_name = each.key
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
# resource "aws_s3_bucket_policy" "aws_glue_data_bucket"{
#     bucket = aws_s3_bucket.aws_glue_databucket.id
#     policy = <<EOF
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "GlueBucketPolicy",
#             "Principal": "*",
#             "Effect": "Allow",
#             "Action": [
#                 "s3:*"
#             ],
#             "Resource":"arn:aws:s3:::aws-glue-data-bucket",
#             "Condition":{
#                 "StringEquals":{
#                     "aws:PrincipalArn": "arn:aws:iam::941598205732:user/1685163"
#                 }
#             }
#         }
#     ]
# }
# EOF
# }
