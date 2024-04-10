resource "aws_ssoadmin_managed_policy_attachment" "lambda_access" {
  instance_arn       = var.instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AWSLambda_ReadOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.client_perm_set.arn
}
resource "aws_ssoadmin_managed_policy_attachment" "s3_access" {
  instance_arn       = var.instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  permission_set_arn = aws_ssoadmin_permission_set.client_perm_set.arn
}
resource "aws_ssoadmin_managed_policy_attachment" "glue_access" {
  instance_arn       = var.instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AWSGlueConsoleFullAccess"
  permission_set_arn = aws_ssoadmin_permission_set.client_perm_set.arn
}
resource "aws_ssoadmin_managed_policy_attachment" "ec2_access" {
  instance_arn       = var.instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  permission_set_arn = aws_ssoadmin_permission_set.client_perm_set.arn
}