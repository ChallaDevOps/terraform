variable "charani-cidr" {
    type = string
    default = "10.10.0.0/16"
}


variable "charani-subnets" {
    type = list(string)
    default = [ "10.10.0.0/24", "10.10.1.0/24" , "10.10.2.0/24"  ]
  
}