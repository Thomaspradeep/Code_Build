resource "aws_ssoadmin_permission_set" "client_perm_set" {
  name        = var.client_name
  description = "Your Permission Set Description"
  instance_arn = var.instance_arn
  session_duration = "PT2H"
}
