# sre-test

## Requirements:

If jenkins wille be used: 
Need to have the following dependencies isntalled in the jenkins server:

Terraform

Node/npm

You will need to have a created s3 bucket to put the zip package in there ( in the current case called: lambdademogh)

change line 9 in Jenkinsfile with the name of the s3 bucket and the desired key (s3://s3-bucket-name/s3_key)

NB: s3 bucket name and bucket should be the same as the declared variables in Terraform s3_bucket and s3_key



## Terraform requirements:

To make terraform code work you should update the terraform.tfvars file with the appropriate input as described in terraform/vars.tf file

To store tfstate in s3 backend you need to uncoment the terraform block in provider.tf and enter bucket_backend name
  
##Variables

You'll need to put avariables in terraform.tfstatevars 
example of tfvars content:


lambda_name = "lambda-test"

apigw_name = "apigw-lambda"

s3_bucket = "bucket-name"  #bucket containing the zip package

s3_key = "v1.1.0/lambda3.zip"  # key of thz zip package

handler = "app.lambdaHandler"

runtime = "nodejs12.x"

iam_lambda = "iam-role-lambda"

iam_policy = "iam-policy-lambda"

s3_bucket_reseized = "lambda-images-reseize"   #bucket that will store the images

shared_credentials= "~/.aws/credentials"
  
## Result/output:

After finishing executing, terraform will return the api url as output, you can use the url to make post requests
