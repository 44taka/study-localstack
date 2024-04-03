resource "aws_iam_role" "example" {
  name               = "example-lambda-exec-role"
  assume_role_policy = data.aws_iam_policy_document.example.json
}
data "aws_iam_policy_document" "example" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }
  }
}
# IAMロールにポリシーをアタッチ
resource "aws_iam_role_policy_attachment" "example_policy_attachment" {
  role       = aws_iam_role.example.name
  policy_arn = aws_iam_policy.example_policy.arn
}
# IAMポリシー
resource "aws_iam_policy" "example_policy" {
  name   = "example-lambda-iam-policy"
  policy = data.aws_iam_policy_document.example_policy.json
}
data "aws_iam_policy_document" "example_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:ListBucket"
    ]
    resources = [
      aws_s3_bucket.example.arn,
      "${aws_s3_bucket.example.arn}/*"
    ]
  }
}