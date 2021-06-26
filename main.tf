provider "aws" {
  version = "~> 2.7"
  region  = "us-east-1"
}
data "aws_vpc" "selected" {
  id = "${var.vpc_id}"
}

data "aws_subnet" "selected" {
  id = var.subnet_id
}
resource "aws_instance" "web" {
  ami = "ami-0ab4d1e9cf9a1215a"
  subnet_id = data.aws_subnet.selected.id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.allow-ssh-all-test.id]
  key_name = var.key_pair_name
  tags = {
    Name = "Terra-test2"
  }  
}
resource "aws_security_group" "allow-ssh-all-test" {
name = "allow-ssh-all-test"
vpc_id = data.aws_vpc.selected.id
ingress {
    cidr_blocks = [
      "0.0.0.0/0"
    ]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }

  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
 }
}


