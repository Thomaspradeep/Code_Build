data "aws_identitystore_group" "client_ad_group" {
  identity_store_id = var.identity_store_id
}
resource "aws_ssoadmin_account_assignment" "account_assignment" {
  instance_arn       = aws_ssoadmin_permission_set.client_perm_set.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.client_perm_set.arn
  principal_type     = "USER"
  principal_id       = "c4689408-80b1-7075-4384-06471b80a0fd"
  target_type        = "AWS_ACCOUNT"
  target_id          = var.account_id
}
