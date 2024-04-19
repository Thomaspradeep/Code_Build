resource "aws_iam_user" "transunion"{
    name = "Transunion"
}

resource "aws_iam_access_key" "transunion1"{
    user = aws_iam_user.transunion.name
}

output "transunion_out"{
     value = {
        "key" = aws_iam_access_key.transunion1.id
        "secret" = aws_iam_access_key.transunion1.secret
     }
     sensitive = true
}

data "aws_iam_role" "Admin_role" {
  name = "Admin_role"
}