resource "aws_lambda_function" "lambda" {
   function_name = var.lambda_name
   s3_bucket = var.s3_bucket
   s3_key    = var.s3_key
   handler = var.handler
   runtime = var.runtime
   timeout= 5
   role = aws_iam_role.lambda_exec.arn
    environment {
    variables = {
      S3_BUCKET = var.s3_bucket_reseized
    }
  }
tracing_config {
  mode = "Active"
}
 }


#attaching policy to the role
resource "aws_iam_role_policy_attachment" "attach-policy" {
  role       = "${aws_iam_role.lambda_exec.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}
#attaching policy to the role
resource "aws_iam_role_policy_attachment" "attach-policy-xray" {
  role       = "${aws_iam_role.lambda_exec.name}"
  policy_arn = "${data.aws_iam_policy.aws_xray_write_only_access.arn}"
}

