data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda_code/transunion_accesskey_rotation/transunion_accesskey_rotation.py"
  output_path = "${path.module}/lambda_code/transunion_accesskey_rotation/transunion_accesskey_rotation.zip"
}

resource "aws_lambda_function" "transunion"{
    filename = "${path.module}/lambda_code/transunion_accesskey_rotation/transunion_accesskey_rotation.zip"
    function_name = "transunion"
    description = "Transunion Access key and Secret key pair rotation"
    role = var.lambda_role
    handler = "accestransunion_accesskey_rotationskey.lambda_handler"
    timeout = 900
    memory_size = 2048
    runtime = "python3.9"
    architectures = ["x86_64"]
    tags = {
      name = "Transuion"
    }
}