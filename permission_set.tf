data "aws_ssoadmin_instances" "matthew_account" {
    provider = aws.mgmt
}

resource "aws_ssoadmin_permission_set" "client_permission_set" {
  name             = "Example"
  description      = "An example"
  instance_arn     = tolist(data.aws_ssoadmin_instances.example.arns)[0]
  session_duration = "PT2H"
}
