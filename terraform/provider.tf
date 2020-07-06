provider "aws" {
  region  = "eu-west-3"
  #add shared crednetial file path
  shared_credentials_file = var.shared_credentials

}

#Please uncomment if you need to store tfstate in ans s3 backend

#terraform {
#  backend "s3" {
#    bucket = "lambda-backendgh"
#    key    = "state.tf"
#    region = "eu-west-3"
#  }
#}
