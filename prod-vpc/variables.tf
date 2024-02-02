variable "region" {
  type = string
  default = "ap-south-1"
}

variable "ami" {
    type = string
    default = "ami-00952f27cf14db9cd"
}

variable "subnet" {
    type = string
    default = ""
}

variable "sg" {
    type = string
    default = ""
  
}


variable "instance_type" {
  type = string
  default = "t2.micro"
}