provider "aws" {
  region = "us-east-1"
}

variable "ami" {
  description = "ami value"
}

variable "instance_type" {
  description = "instance type like t2.micro"
}

module "ec2instance" {
  source = "./modules/ec2_instance"
  ami = var.ami
  instance_type = var.instance_type
}
