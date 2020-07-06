provider "aws" {
  region                  = "eu-west-3"
  #add shared crednetial file path
  shared_credentials_file = var.shared_credentials

}

#terraform {
#  backend "s3" {
#    bucket = var.bucket_backend
#    key    = var.s3_key_backend
#    region = "eu-west-3"
 # }
#}
