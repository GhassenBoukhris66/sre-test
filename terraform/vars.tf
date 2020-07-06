variable "lambda_name" {
  
description = "name of the lambda function"
}

variable "apigw_name" {

description = "name of the api gateway"
}
variable "s3_bucket" {

description = "name of the s3 bucket containing the zip package"
}

variable "s3_key" {

description = "name of the s3 key of the zip package"
}

variable "handler" {
description = "lambda handler"
}

variable "runtime"{

description = "lambda runtime"

}

variable "iam_lambda"{
description = "lambda iam role"

}

variable "iam_policy" {
description = "policy attached to lambda role"
}

variable "s3_bucket_reseized" {
description = "bucket where the reseized images will be stored"
}
variable "shared_credentials" {
description = "directory where shared credentials are stored"
}


