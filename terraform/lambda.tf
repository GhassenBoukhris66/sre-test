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
 }

 # IAM role which dictates what other AWS services the Lambda function
 # may access.
 resource "aws_iam_role" "lambda_exec" {
   name = var.iam_lambda

   assume_role_policy = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
     {
       "Action": "sts:AssumeRole",
       "Principal": {
         "Service": "lambda.amazonaws.com"
       },
       "Effect": "Allow",
       "Sid": ""
     }
   ]
}
 EOF

 }
 #Created Policy for IAM Role
resource "aws_iam_policy" "policy" {
  name = var.iam_policy
  description = "policy to attach to lambda"


      policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
    {
        "Effect": "Allow",
        "Action": [
            "logs:*"
        ],
        "Resource": "arn:aws:logs:*:*:*"
    },
    {
        "Effect": "Allow",
        "Action": [
            "s3:*"
        ],
        "Resource": [
         "arn:aws:s3::: ${var.s3_bucket_reseized}",
         "arn:aws:s3:::${var.s3_bucket_reseized}/*"
]
    }
]

} 
    EOF
    }

#attaching policy to the role
resource "aws_iam_role_policy_attachment" "attach-policy" {
  role       = "${aws_iam_role.lambda_exec.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
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
