output "instance_pub_ip" {
  value = aws_instance.ec2-server[*].public_ip
}
output "instance_pub_dns" {
  value = aws_instance.ec2-server[*].public_dns
}
output "instance_pri_ip" {
  value = aws_instance.ec2-server[*].private_ip
}
output "instance_pri_dns" {
  value = aws_instance.ec2-server[*].private_dns
}

output "ec2_id" {
  value = aws_instance.ec2-server[*].id
}   
# output "ec2_hostname" {
#   value = aws_instance.ec2-server[*].hostname
# }  

output "instance_state" {
  value = aws_instance.ec2-server[*].instance_state
}

output "instance_type" {
  value = aws_instance.ec2-server[*].instance_type
}

# output "instance_id" {
#   value = aws_instance.ec2-server
# }


output "account_id" {
    value = data.aws_caller_identity.cuurent.account_id
}
output "caller_arn" {
    value = data.aws_caller_identity.cuurent.arn
}
output "caller_user" {
    value = data.aws_caller_identity.cuurent.user_id
}