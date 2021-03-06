provider "aws" {
  access_key = "........"
  secret_key = ".......  "
  region = "ap-south-1"
}
resource "aws_security_group" "allow_ssh" {
        name = "SSH"
        description = "Allow SSH Connection!"
        vpc_id = "${aws_vpc.example.id}"
        egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }
        ingress {
                from_port = 22
                to_port = 22
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }
        ingress {
                from_port = 80
                to_port = 80
                protocol = "tcp"
                cidr_blocks = ["0.0.0.0/0"]
        }
        tags {
                Name = "allow_ssh"
        }
}
resource "aws_instance" "example" {
  ami = "ami-04ea996e7a3e7ad6b"
  instance_type = "t2.micro"
  subnet_id = "${aws_subnet.us-east-1a-public.id}"
  security_groups = ["${aws_security_group.allow_ssh.id}"]
  key_name = "ciciya"
  tags {
                Name = "docker-test"
  }
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
}

resource "aws_subnet" "us-east-1a-public" {
  vpc_id = "${aws_vpc.example.id}"
  cidr_block = "10.0.1.0/25"
  availability_zone = "ap-south-1a"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.example.id}"
}

resource "aws_eip" "instance" {
    vpc = true
    instance = "${aws_instance.example.id}"
}
output "bastion.ip" {
  value = "${aws_eip.instance.public_ip}"
}
