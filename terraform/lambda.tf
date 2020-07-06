resource "aws_lambda_function" "lambda" {
   function_name = var.lambda_name
   s3_bucket = var.s3_bucket
   s3_key    = var.s3_key
   handler = var.handler
   runtime = var.runtime
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
 resource "aws_api_gateway_resource" "proxy" {
   rest_api_id = aws_api_gateway_rest_api.apigw.id
   parent_id   = aws_api_gateway_rest_api.apigw.root_resource_id
   path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "proxy" {
   rest_api_id   = aws_api_gateway_rest_api.apigw.id
   resource_id   = aws_api_gateway_resource.proxy.id
   http_method   = "POST"
   authorization = "NONE"
 }

resource "aws_lambda_permission" "apigw" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.lambda.function_name
   principal     = "apigateway.amazonaws.com"

   source_arn = "${aws_api_gateway_rest_api.apigw.execution_arn}/*/*"
 }
