resource "aws_iam_user" "transunion"{
    name = "Transunion"
}

resource "aws_iam_access_key" "transunion1"{
    user = aws_iam_user.transunion.name
}

output "transunion_out"{
     value = {
        "key" = aws_iam_access_key.transunion.id
        "secret" = aws_iam_access_key.tranunion.secret
     }
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