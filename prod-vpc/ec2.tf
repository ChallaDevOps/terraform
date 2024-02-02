data "aws_caller_identity" "cuurent" {}

resource "aws_instance" "ec2-server" {
  ami           = var.ami
  count =  2         #to deploy mutliple servers
  instance_type = var.instance_type
  associate_public_ip_address = true
  #subnet_id = aws_subnet.pub-sn.id #"subnet-0cf5c8a20685ee051"
  vpc_security_group_ids = [aws_security_group.charani-sg.id]
  #security_groups = [ "sg-0ab53f257bb35a25e" ] ## we can use direct Sge
  #key_name = aws_key_pair.deployer.id
  key_name = "terraform"
 
 
  tags = {
    Name = "Production Terrafotrm Server-${count.index+1}"

  }
}


