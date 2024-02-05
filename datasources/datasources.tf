data "aws_vpc" "vpc" {
  
}

data "aws_vpc" "default" {
  cidr_block = "172.31.0.0/16"
}
