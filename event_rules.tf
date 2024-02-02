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