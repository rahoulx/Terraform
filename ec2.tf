#instance_in_pub_subnet
resource "aws_instance" "pub_instance" {
  count         = var.instance_count #1,2
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id = element(aws_subnet.public_subnet.*.id, count.index)
  key_name      = "mumbai-awskey"
  vpc_security_group_ids = [aws_security_group.aws_sg.id]
  user_data     = file("${path.module}/script.sh")

  tags = {
    Name = "${var.name}-pub-inst-${count.index + 1}"
  }
}


#instance_in_prv_subnet
resource "aws_instance" "prv_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id =aws_subnet.private_subnet.id
  key_name      = "mumbai-awskey"
  tags = {
    Name = "${var.name}-prv-inst"
  }
}


#aws_sg_config_for_custom_vpc
resource "aws_security_group" "aws_sg" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.prod_vpc.id
  
  dynamic "ingress" {
    for_each = [80, 443, 22, 8080, 3306]
    iterator = port
    content {
      #description = "TLS from VPC"
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  tags = {
   Name = "${var.name}-sg"
  }
}


