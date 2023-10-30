variable "ami_id"{
type = string
default = "ami-06791f9213cbb608b"
}

variable "instance_type" {
type = string
default = "t2.micro"
}

variable "security_group" {
type = string
default = "sg-05791dcd424e78d69"
}

variable "pem_file_location" {
type = string
default = "/home/aditya/terraform_ws/ws1-ec2/tf-key.pem"
}
