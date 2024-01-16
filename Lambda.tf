resource "null_resource" "dummy_trigger" {
  triggers = {
    timestamp = timestamp()
  }
}
data "archive_file" "lambda" {
  type        = "zip"
  source_dir = "lambda_code/transunion_accesskey_rotation"
  output_path = "transunion_accesskey_rotation.zip"
  depends_on = [ 
    null_resource.dummy_trigger
   ]
}

resource "aws_lambda_function" "transunion"{
    filename = "${data.archive_file.lambda.output_path}"
    function_name = "transunion"
    description = "Transunion Access key and Secret key pair rotation"
    role = aws_iam_role.tranunion_lambda_role.arn
    handler = "transunion_accesskey_rotation.lambda_handler"
    timeout = 900
    memory_size = 2048
    runtime = "python3.9"
    architectures = ["x86_64"]
    tags = {
      name = "Transuion"
    }
}