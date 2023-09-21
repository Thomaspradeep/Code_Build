resource "aws_s3_bucket" "log_bucket" {
    bucket = "log-${var.bucket_name}"

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

    tags = {
        Env = "Dev"
    }
}

resource "aws_s3_bucket_versioning" "version"{
    bucket = aws_s3_bucket.CDS_Infra_bucket.id
    versioning_configuration{
        status  = "Enabled"
    }
}
#readon only
resource "aws_s3_bucket_object" "object"{
    bucket = aws_s3_bucket.log_bucket.id
    key = "Log/land_bucket"
}



