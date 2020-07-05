provider "aws" {
  region                  = "eu-west-3"
  #add shared crednetial file path
  shared_credentials_file = ******


}

 terraform {
  backend "s3" {
    bucket = ***
    key    = ***
    region = "eu-west-3"
  }
}
