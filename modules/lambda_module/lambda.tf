# Creates ZIP file containing the Lambda function
data "archive_file" "ses_email_forwarder" {
  type        = "zip"
  source_dir  = "${path.module}/lambda/ses_email_forwarder/"
  output_path = "${path.module}/lambda/ses_email_forwarder.zip"
}


resource "aws_lambda_permission" "allow_sns" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.email_forwarder_function.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = var.source_arn_lambda
}

# Lambda Function Creation
resource "aws_lambda_function" "email_forwarder_function" {
  function_name    = var.lambda_name
  description      = local.email_forwarder_function_desc
  role             = aws_iam_role.iam_role_for_lambda.arn
  memory_size      = var.memory_size
  runtime          = var.runtime
  timeout          = var.timeout
  handler          = "ses_email_forwarder.lambda_handler"
  filename         = "${path.module}/lambda/ses_email_forwarder.zip"
  source_code_hash = data.archive_file.ses_email_forwarder.output_base64sha256
  depends_on       = [aws_iam_role.iam_role_for_lambda]
  environment {
    variables = {
      tlz_sender   = "tlz-account@${var.domain}",
      tlz_receiver = var.dl_email_address
    }
  }
}