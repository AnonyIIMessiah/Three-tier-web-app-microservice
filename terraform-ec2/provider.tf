terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket  = "tf-microservice-terraform-state"
    key     = "microservice/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}

data "aws_vpc" "selected" {
  id = var.vpc_id
}


resource "aws_iam_role" "iam-role-for-ec2" {
  name = "iam-role-for-ec2"



  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "instance-profile" {
  name = "instance-profile"
  role = aws_iam_role.iam-role-for-ec2.name

}