#VPC
resource "aws_vpc" "prod_vpc" {
  cidr_block = var.vpc_cidir
  tags = {
    Name = "${var.name}-VPC"
}
}

#public_subnet
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.prod_vpc.id
  cidr_block = var.pub_cidir
  availability_zone = var.pub_az
  map_public_ip_on_launch =true

  tags = {
    Name = "${var.name}-pub-sub"
}
}

#private_subnet
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.prod_vpc.id
  cidr_block = var.prv_cidir
  availability_zone = var.prv_az
  tags = {
    Name = "${var.name}-prv-sub"
}
}

#internet_gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.prod_vpc.id
   tags = {
    Name = "${var.name}-igw"
}
}

#ip_for_nat
resource "aws_eip" "nat_ip" {
  vpc      = true
  tags = {
    Name = "${var.name}-eip"
}
}

#nat_gateway
resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_ip.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = "${var.name}-nat"
}
}

#route_table_for_pub_subnet
resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.prod_vpc.id
  tags ={
    Name = "${var.name}-pub-rt"
}

#route_pub_to_igw
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

}

#associate_rt_to_pub_subnet
resource "aws_route_table_association" "pub_asso" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.pub_rt.id
}



#route_table_for_prv_subnet
resource "aws_route_table" "prv_rt" {
  vpc_id = aws_vpc.prod_vpc.id
  tags = {
    Name = "${var.name}-prv-rt"
}

#route_pub_to_natgw
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

}

#associate_rt_to_prv_subnet
resource "aws_route_table_association" "prv_asso" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.prv_rt.id
}
