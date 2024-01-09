data "archive_file" "lambda" {
  type        = "zip"
  source_file = "AccessKey.py"
  output_path = "AccessKey.zip"
}

resource "aws_lambda_function" "transunion"{
    filename = "AccessKey.zip"
    function_name = "Transunion_Access_Key"
    description = "Transunion Access key and Secret key pair rotation"
    role = var.lambda_role
    handler = "Trans"
    timeout = 900
    memory_size = 2048
    runtime = "python3.9"
}