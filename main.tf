provider "aws" {
    region  = "ap-south-1"
}

# aws_ec2_config

resource "aws_instance" "webinstance" {
  ami           = "ami-0b08bfc6ff7069aff"
  instance_type = "t2.micro"
  associate_public_ip_address = true
  key_name = "mumbai-awskey"
  security_groups = ["sg-09ac645ba936eab49"]
  vpc_security_group_ids = [aws_security_group.aws_sg.id]

  root_block_device {
    volume_size = 10
    volume_type = "gp2"
  }

  tags = {
    Name = "Devopsprod"
  }
}

#aws_sg_config_1port

resource "aws_security_group" "aws_sg" {
  name        = "security-group"
  description = "Allow SSH and HTTP"
  vpc_id      = "vpc-0b1f07657a4fba9ec"

  ingress {
    description      = "TLS from my VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-demo-tf-sg"
  }
}

