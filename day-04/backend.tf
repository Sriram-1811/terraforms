terraform {
  backend "s3" {
    bucket = "sriram-s3-bucket-demo"
    region = "us-east-1"
    key = "sriram/terraform.tfstate"
  }
}