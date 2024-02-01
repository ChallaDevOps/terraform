resource "aws_instance" "ec2-server" {
  ami           = "ami-00952f27cf14db9cd"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  subnet_id = aws_subnet.pub-sn.id #"subnet-0cf5c8a20685ee051"
  vpc_security_group_ids = [aws_security_group.charani-sg.id]
  #security_groups = [ "sg-0ab53f257bb35a25e" ] ## we can use direct Sge
  key_name = aws_key_pair.deployer.id

  tags = {
    Name = "Production Terrafotrm Server"

  }
}


resource "aws_key_pair" "deployer" {
  key_name   = "terraform"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQClcu4uVpzIWQBX4aeBAsK5wb9bNCsdGsN4C0Ql3HsnmBZpIkrPDcKVTkw9QB/PwkPshOPSddKWI/ni//hpC/D6lHqqAkGReCZBNo6z5MxLa8B9Ppwf1LKDOP2hwuZ+MyhRL6nWquaUeMqjiBmhePIjPn4RaQ2fW9CrfCDkA1FEXVtfvAvVep01MIh9BUf21JJySszaPH9bislt/EYsUp+IvKKive6qv2YORATxEboag74Fum9hry6awjCO8hoWRTD/2JY73jDUgIId1Lwp0UXEhE48IUGhimhurVr1g9I7rJFhi1UUIJgy5YhOVho46MpRrVgHwZJC6qAy7KSIehQ2qlsakKkgwbgJMpIbiiRuO"
  
}
