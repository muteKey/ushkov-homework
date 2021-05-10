provider "aws" {
  region = "eu-west-1"
}

terraform {
  backend "s3" {
    bucket = "itea-tf-ushkov-states"
    key = "terraform.tfstate"
    region = "eu-west-1"
  }
}