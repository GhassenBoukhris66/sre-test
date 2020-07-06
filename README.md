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

To make terraform code work you should update the terraform.tfvars file with the appropriate nput as described in terraform/vars.tf file
