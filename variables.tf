variable "bastion_key_path" {
  description = "My public ssh key"
   default = "~/.ssh/id_rsa.pub"
}
variable "openshift_key_path" {
  description = "My public ssh key"
   default = "./helper_scripts/id_rsa.pub"
}
variable "bastion_key_name" {
  description = "Desired name of AWS key pair"
  default     = "bastion"
}
variable "openshift_key_name" {
  description = "Desired name of AWS key pair"
  default     = "openshift"
}
variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-2"
}

variable "aws_availability_zone" {
  description = "Aws availability zone to launch volumes"
  default = "us-east-2a"  
}

variable "aws_amis" {
  default = {
    us-east-2 = "ami-0b500ef59d8335eee"
  }
}
variable "vpc_cidr" {
    default = "10.0.0.0/20"
  description = "the vpc cdir range"
}
variable "public_subnet_a" {
  default = "10.0.0.0/24"
  description = "Public subnet AZ A"
}
variable "public_subnet_b" {
  default = "10.0.4.0/24"
  description = "Public subnet AZ B"
}
variable "public_subnet_c" {
  default = "10.0.8.0/24"
  description = "Public subnet AZ C"
}
variable "private_subnet_a" {
  default = "10.0.1.0/24"
  description = "Private subnet AZ A"
}
variable "private_subnet_b" {
  default = "10.0.5.0/24"
  description = "Private subnet AZ B"
}
variable "private_subnet_c" {
  default = "10.0.9.0/24"
  description = "Private subnet AZ C"
}
