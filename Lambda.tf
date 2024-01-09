data "archive_file" "lambda" {
  type        = "zip"
  source_file = "AccessKey.py"
  output_path = "accesskey.zip"
}

resource "aws_lambda_function" "transunion"{
    filename = "accesskey.zip"
    function_name = "Transunion_Access_Key"
    description = "Transunion Access key and Secret key pair rotation"
    role = var.lambda_role
    handler = "lambda.lambda_handler"
    timeout = 900
    memory_size = 2048
    runtime = "python3.9"
    architectures = ["x86_64"]
    tags = {
      name = "Transuion"
    }
}