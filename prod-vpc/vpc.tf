resource "aws_vpc" "charani" {
  cidr_block       = "192.168.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Production VPC"
  }
}

resource "aws_subnet" "pub-sn" {
    vpc_id = aws_vpc.charani.id
    cidr_block = "192.168.1.0/24"
    availability_zone = "ap-south-1a"

    tags = {
      Name = "Public SN"
    } 
    depends_on = [ 
        aws_vpc.charani
     ]
}


resource "aws_subnet" "pri-sn" {
    vpc_id = aws_vpc.charani.id
    cidr_block = "192.168.2.0/24"
    availability_zone = "ap-south-1a"

    tags = {
      Name = "Private SN"
    } 
    depends_on = [ aws_vpc.charani ]
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.charani.id

  tags = {
    Name = "Prod-IGW"
  }
  depends_on = [ aws_vpc.charani ]
}

resource "aws_eip" "lb" {
  domain   = "vpc"
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.lb.id
  subnet_id     = aws_subnet.pri-sn.id

  tags = {
    Name = "Prod NAT Gateway"
  }
  depends_on = [ aws_vpc.charani ]

#   # To ensure proper ordering, it is recommended to add an explicit dependency
#   # on the Internet Gateway for the VPC.
#   depends_on = [aws_internet_gateway.example]
}

resource "aws_route_table" "pub-rt" {
  vpc_id = aws_vpc.charani.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Prod public rt"
  }
  depends_on = [ aws_vpc.charani ]
}

resource "aws_route_table" "pri-rt" {
  vpc_id = aws_vpc.charani.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name = "Prod private rt"
  }
  depends_on = [ 
      aws_vpc.charani,
      aws_subnet.pri-sn,
    
    ]
}




resource "aws_security_group" "charani-sg" {
  name = "Prod VPC SG"
  description = "SG for Prod VPC"
  vpc_id = aws_vpc.charani.id

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
   ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
   ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks      = [aws_vpc.charani.cidr_block]
  }
  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    cidr_blocks      = [aws_vpc.charani.cidr_block]
  }
}


