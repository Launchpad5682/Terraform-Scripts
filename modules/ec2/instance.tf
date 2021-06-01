provider "aws" {
  region  = "ap-south-1"
  profile = "default"
}

resource "aws_instance" "os1" {
  ami           = "ami-010aff33ed5991201"
  instance_type = var.instanceType
  tags = {
    Name = "My First TF OS 1"
  }
}

output "o1" {
  value = aws_instance.os1
}
