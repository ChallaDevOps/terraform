# VPC for Staging Environments 
resource "aws_vpc" "staging" {
    cidr_block = "10.1.0.0/16"
    instance_tenancy = "default"

    tags = {
      Name = "Staging VPC"
      Environmnet = "Staging"
      Owner = "Charani"
    }
}

#public Subnet 
resource "aws_subnet" "public_sn" {
  vpc_id = aws_vpc.staging.id
  cidr_block = "10.1.1.0/24"

  tags = {
    Name = "Staging Public Subnet"
    Purpose = "To delpoy the Public servers"
  }
}
#private Subnet 
resource "aws_subnet" "private_sn" {
  vpc_id = aws_vpc.staging.id
  cidr_block = "10.1.2.0/24"

  tags = {
    Name = "Staging private subnet"
    Purpose = "To delpoy the private server"
  }
}

###IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.staging.id

  tags = {
    Name = "IGW for Staging VPC"
  }
}

##  EIP
resource "aws_eip" "eip" {
  domain = "vpc"
}

# NGW
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.private_sn.id

  tags = {
    Name = "GW for NAT"
  }
}


## Route table for Staging VPC
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.staging.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Staging Public Route table"
  }
}


##Priver RT
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.staging.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "Staging Private Route table"
  }
}


#SG
resource "aws_security_group" "sg" {
  name = "Staging VPC Security Group"
  description = "Allow TLS inbound traffic"
  vpc_id = aws_vpc.staging

  ingress {
    description = "TLS from VPC"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "Staging VPC SG"
  }
}

resource "aws_route_table_association" "public_rt" {
  subnet_id = aws_subnet.public_sn.id
  route_table_id = aws_route_table.public_rt
  
}


resource "aws_route_table_association" "privare_rt" {
  subnet_id = aws_subnet.private_sn.id
  route_table_id = aws_route_table.private_rt
  
}