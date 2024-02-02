output "vpc" {
  value = data.aws_vpc.vpc.id
}

output "default-vpc" {
  value = data.aws_vpc.default.id
}