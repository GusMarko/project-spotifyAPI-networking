variable "vpc_cidr_block" {
  type = string
  description = "VPC cidr block"
}

variable "pub_sub_cidr" {
  type = string
  description = "public subnet cidr block"
}

variable "priv_sub_cidr" {
  type = string
  description = "private subnet cidr block"
}

variable "env" {
  type = string
  description = "current branch/environment - used in tags imported thru helper script"
}

variable "aws_region" {
  type = string
}

variable "access_key" {
  type = string
  description = "AWS credentials"
}

variable "secret_key" {
  type = string
  description = "AWS credentials"
}