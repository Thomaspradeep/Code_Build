data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/lambda_code/transunion_accesskey_rotation/transunion_accesskey_rotation.py"
  output_path = "${path.module}/lambda_code/transunion_accesskey_rotation/transunion_accesskey_rotation.zip"
}

resource "aws_lambda_function" "transunion"{
    filename = "${data.archive_file.lambda.output_path}"
    function_name = "transunion"
    description = "Transunion Access key and Secret key pair rotation"
    role = aws_iam_role.tranunion_lambda_role
    handler = "transunion_accesskey_rotation.lambda_handler"
    timeout = 900
    memory_size = 2048
    runtime = "python3.9"
    architectures = ["x86_64"]
    tags = {
      name = "Transuion"
    }
}

resource "aws_cloudwatch_event_rule" "every_five_minutes" {
    name = "every-five-minutes"
    description = "Fires every five minutes"
    schedule_expression = "rate(5 minutes)"
}

resource "aws_cloudwatch_event_target" "check_foo_every_five_minutes" {
    rule = aws_cloudwatch_event_rule.every_five_minutes.name
    target_id = "transunion"
    arn = aws_lambda_function.transunion.arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_check_foo" {
    statement_id = "AllowExecutionFromCloudWatch"
    action = "lambda:InvokeFunction"
    function_name = aws_lambda_function.transunion.function_name
    principal = "events.amazonaws.com"
    source_arn = aws_cloudwatch_event_rule.every_five_minutes.arn
}