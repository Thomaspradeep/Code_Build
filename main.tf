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

resource "aws_s3_bucket" "glue_bucket_matthew"{
    bucket = "bucket101matthew1"
    
    versioning{
    enabled = true
}
}

resource "aws_iam_user" "transunion"{
    name = "Transunion"
}

resource "aws_iam_access_key" "transunion"{
    user = aws_iam_user.transunion.name
}

output "Transunion"{
     value = aws_iam_access_key.transunion.encrypted_secret
     sensitive = true
}

data "aws_iam_user" "datauser1_user"{
    user_name = "datauser1"
}
resource "aws_iam_access_key" "datauser1_access_key"{
    user = data.aws_iam_user.datauser1_user.user_name
}

output "datauser1_access_key"{
     value = {
        "key" = aws_iam_access_key.datauser1_access_key.id
        "secret" = aws_iam_access_key.datauser1_access_key.secret
     }    
     sensitive = true
}