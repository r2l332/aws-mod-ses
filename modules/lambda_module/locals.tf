locals {
  email_forwarder_function_desc = "Lambda function to forward email contents to vis SES"
  sns_lambda_topic_desc         = "SNS topic to deliver email to Santander DL"
  iam_role_for_lambda_desc      = "IAM role for Lambda to access required services"
}
