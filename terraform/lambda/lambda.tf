resource "aws_lambda_function" "example" {
  function_name = "example-function"
  role          = aws_iam_role.example.arn

  filename      = "example-function.zip"
  handler       = "main.handler"
  runtime       = "python3.12"
  memory_size   = 256
  timeout       = 3
  architectures = ["x86_64"]
  ephemeral_storage {
    size = 512
  }
  package_type = "Zip"
}

resource "aws_lambda_permission" "example" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.example.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.example.arn
}