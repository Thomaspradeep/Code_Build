# created this d3 testing
# resource "aws_cloudwatch_event_rule" "glue_job_error" {
#     name = "Glue_Error"
#     description = "Collect Glue error messages in CloudWatch"
#     is_enabled = true
#     event_pattern = <<EOF
# {
#         "source":[
#             "aws.glue"
#         ],
#         "detail-type": [
#             "Glue Job Stage Chagne"
#         ],
#         "detail": {
#             "jobName": ["dlx-ddm-branch-distance","dlx-ddm-sftp-deceased-flag"],
#             "state": ["FAILED, STOPPED", "TIMEOUT"]
#         }
# }
# EOF
# }

resource "aws_glue_job" "MyFirstJob" {
  name          = "MyFirstJob"
  description   = "Example Glue job"
  role_arn      = "arn:aws:iam::941598205732:role/service-role/AWSGlueServiceRole-Test"
  command {
    name   = "glueetl"
    script_location = "s3://glue-bucket-matthew/script.py"
  }
  default_arguments = {
    "--job-language" = "python"
  }
}

resource "aws_cloudwatch_event_rule" "trigger_rule" {
  name                = "glue-job-trigger-rule"
  schedule_expression = "rate(10 minutes)"  # Trigger daily at midnight UTC
}

resource "aws_cloudwatch_event_target" "glue_job_target" {
  rule      = aws_cloudwatch_event_rule.trigger_rule.name
  target_id = "glue-job-target"
  arn       = aws_glue_job.MyFirstJob.arn
}

