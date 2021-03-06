variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_key_path" {}
variable "aws_key_name" {}
variable "home_cidr" {}
variable "aws_region" {
  default = "eu-west-2"
}

variable "amis" {
  description = "AMI configuration per region"
  default = {
    eu-west-2 = "ami-cc7066a8" #ubuntu 16.04
  }
}

variable "vpc_cidr" {
  description = "full VPC CIDR"
  default = "10.0.0.0/16"
}

variable "public1_subnet_cidr" {
  description = "CIDR for Primary Public Subnet"
  default = "10.0.0.0/24"
}

variable "public2_subnet_cidr" {
  description = "CIDR for Secondary Public Subnet"
  default = "10.0.1.0/24"
}

variable "private1_subnet_cidr" {
  description = "CIDR for Primary Private Subnet"
  default = "10.0.2.0/24"
}

variable "private2_subnet_cidr" {
  description = "CIDR for Secondary Private Subnet"
  default = "10.0.3.0/24"
}
