variable "ami_id" {
  default = "ami-063d4ab14480ac177"
  description = "Amazon Linux 2 AMI (HVM), SSD Volume Type"
}

variable "aws_region" {
  default = "eu-west-1"
}

variable "instance_type" {
  default = "t2.micro"
  description = "Default free tier eligible instance type"
}

variable "environment" {
  default = "dev"
}

variable "volume_size" {
  default = 8
}

variable "ebs_availability_zone" {
  default = "eu-west-1a"
}

variable "volume_device_name" {
  default = "/dev/sdh"
}

variable "short_name" {
  default = "itea"
}

variable "public_subnets" {
  type = list(object({
    availability_zone = string
    cidr_block = string
  }))
}