resource "aws_lambda_function" "transunion"{
    function_name = "Transunion_Access_Key"
    description = "Transunion Access key and Secret key pair rotation"
    role = data.aws_iam_role.Admin_role
    handler = "Trans"
    timeout = 900
    memory_size = 2048
    runtime = "python3.9"
}