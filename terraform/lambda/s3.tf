resource "aws_s3_bucket" "example" {
  bucket        = "example-bucket"
  force_destroy = true
}

resource "aws_s3_bucket_notification" "example" {
  bucket = aws_s3_bucket.example.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.example.arn
    events              = ["s3:ObjectCreated:*"]
  }
}