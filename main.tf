# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
}
# Declare the data source
data "aws_availability_zones" "available" {}
data "template_file" "sysprep-bastion" {
  template = "${file("./helper_scripts/sysprep-bastion.sh")}"
}
terraform {
  backend "s3" {
    bucket = "emreozkan-terraform-data"
    key    = "terraform.tfstate"
    region = "eu-west-1"
  }
}
