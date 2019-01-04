provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

resource "aws_instance" "example_nig" {
  ami           = "ami-2757f631"
  instance_type = "t2.micro"
  key_name = "nig_octo_aws"
  tags = {
    name = "NIG"
    AutoStop = "true"
  }
  vpc_security_group_ids = ["sg-24fccf59"]
  provisioner "local-exec" {
    command = "echo ${aws_instance.example_nig.public_ip} > ip_address.txt"
  }
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.example_nig.id}"
}