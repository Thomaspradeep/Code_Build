resource "aws_kms_key" "demo" {
  description            = "KMS key 1"
  deletion_window_in_days = 10
}

resource "aws_kms_alias" "demo" {
  name          = "alias/demo"
  target_key_id = aws_kms_key.demo.key_id
}
