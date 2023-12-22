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

output "aws_iam_smtp_password_v4"{
     value = {
        "key" = aws_iam_access_key.transunion.id
        "secret" = aws_iam_access_key.tranunion.secret
     }    
}