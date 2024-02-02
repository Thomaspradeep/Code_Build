# resource "aws_cloudwatch_event_rule" "every_five_minutes" {
#     name = "every-five-minutes"
#     description = "Fires every five minutes"
#     schedule_expression = "rate(30 minutes)"
#     is_enabled = false
# }

# resource "aws_cloudwatch_event_target" "check_foo_every_five_minutes" {
#     rule = aws_cloudwatch_event_rule.every_five_minutes.name
#     target_id = "transunion"
#     arn = aws_lambda_function.transunion.arn
# }

# resource "aws_lambda_permission" "allow_cloudwatch_to_call_check_foo" {
#     statement_id = "AllowExecutionFromCloudWatch"
#     action = "lambda:InvokeFunction"
#     function_name = aws_lambda_function.transunion.function_name
#     principal = "events.amazonaws.com"
#     source_arn = aws_cloudwatch_event_rule.every_five_minutes.arn
# }


# resource "aws_cloudwatch_event_rule" "gateway_check_transunion_optout_lambda_target" {
#     name = "dlx-ddm-gateway-check"
#     description = "Fires every five minutes"
#     schedule_expression = "rate(30 minutes)"
#     is_enabled = false
# }

# resource "aws_cloudwatch_event_target" "gateway_check_transunion_optout_lambda_targe"{
#     rule = aws_cloudwatch_event_rule.gateway_check_transunion_optout_lambda_target.name
#     target_id = "trigger-data-validation-lambda"
#     arn = aws_lambda_function.transunion.arn
#     input = jsonencode(
#         {
#             bucket = {
#                 name = [
#                     "matthews-bucket-91423",
#                     ]
#                 }
#             key = [
#                 {
#                     prefix = "consume/experian/prescreen/"
#                 },
#                 ]
#             parameters = {
#                 asset     = "optout"
#                 entity    = "transunion"
#                 sns_topic = [
#                     "test",
#                     ]
#                 }
#             }
#         )
# }