#create api_gw rest api
resource "aws_api_gateway_rest_api" "apigw" {
  name        = var.apigw_name
  description = "Terraform Serverless Application "
  binary_media_types= ["multipart/form-data"]
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

#grant permission to invoke lambda
resource "aws_lambda_permission" "apigw" {
   statement_id  = "AllowAPIGatewayInvoke"
   action        = "lambda:InvokeFunction"
   function_name = aws_lambda_function.lambda.function_name
   principal     = "apigateway.amazonaws.com"

   source_arn = "${aws_api_gateway_rest_api.apigw.execution_arn}/*/*"
 }
resource "aws_api_gateway_integration" "lambda" {
   rest_api_id = aws_api_gateway_rest_api.apigw.id
   resource_id = aws_api_gateway_method.proxy.resource_id
   http_method = aws_api_gateway_method.proxy.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.lambda.invoke_arn
 }

 resource "aws_api_gateway_method" "proxy_root" {
   rest_api_id   = aws_api_gateway_rest_api.apigw.id
   resource_id   = aws_api_gateway_rest_api.apigw.root_resource_id
   http_method   = "POST"
   authorization = "NONE"
 }

#ensure lambda and apigw integration
 resource "aws_api_gateway_integration" "lambda_root" {
   rest_api_id = aws_api_gateway_rest_api.apigw.id
   resource_id = aws_api_gateway_method.proxy_root.resource_id
   http_method = aws_api_gateway_method.proxy_root.http_method

   integration_http_method = "POST"
   type                    = "AWS_PROXY"
   uri                     = aws_lambda_function.lambda.invoke_arn
 }

#deploy api gateway
resource "aws_api_gateway_deployment" "apigwdeploy" {
   depends_on = [
     aws_api_gateway_integration.lambda,
     aws_api_gateway_integration.lambda_root,
   ]

   rest_api_id = aws_api_gateway_rest_api.apigw.id
   stage_name  = "deploy"
 }
output "base_url" {
  value = aws_api_gateway_deployment.apigwdeploy.invoke_url
}

# grant permission to apigw to communicate with cloud_watch
resource "aws_api_gateway_account" "apigw_account" {
  cloudwatch_role_arn = "${aws_iam_role.cloudwatch.arn}"
}

#mange methode settings
resource "aws_api_gateway_method_settings" "general_settings" {
  depends_on = [
    aws_api_gateway_account.apigw_account,
  ]
  rest_api_id = "${aws_api_gateway_rest_api.apigw.id}"
  stage_name  = "${aws_api_gateway_deployment.apigwdeploy.stage_name}"
  method_path = "*/*"

  settings {
    # Enable CloudWatch logging and metrics
    metrics_enabled        = true
    data_trace_enabled     = true
    logging_level          = "INFO"

    # Limit the rate of calls to prevent abuse and unwanted charges
    throttling_rate_limit  = 100
    throttling_burst_limit = 50
  }
}
