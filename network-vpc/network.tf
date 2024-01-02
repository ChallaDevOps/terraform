


##VPC creation 
resource "aws_vpc" "charani" {
  cidr_block       = var.charani-cidr
  instance_tenancy = "default"

  tags = {
    Name = "Charani Staging"
  }
}


# web Subnet creation  under VPC
resource "aws_subnet" "web" {
  vpc_id     = aws_vpc.charani.id
  cidr_block = var.charani-cidrs[0]
  availability_zone = "ap-south-1a"

  tags = {
    Name = "Web subnet"
  }
}



# APP Subnet creation  under VPC
resource "aws_subnet" "app" {
  vpc_id     = aws_vpc.charani.id
  cidr_block = var.charani-cidrs[1]
  availability_zone = "ap-south-1a"

  tags = {
    Name = "APP subnet"
  }
}


#DB Subnet creation  under VPC
resource "aws_subnet" "db" {
  vpc_id     = aws_vpc.charani.id
  cidr_block = var.charani-cidrs[2]
  availability_zone = "ap-south-1a"

  tags = {
    Name = "DB subnet"
  }
}