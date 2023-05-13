provider "aws" {
    region  = "ap-south-1"
  # Configuration options
}

resource "aws_instance" "webinstance" {
  ami           = "ami-0b08bfc6ff7069aff"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "mumbai-awskey"
  security_groups = "sg-09ac645ba936eab49"

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 10
    volume_type = "gp2"
  }

  tags = {
    Name = "Devopsprod"
  }
}
