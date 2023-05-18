resource "aws_vpc" "prod_vpc" {
  cidr_block = var.vpc_cidir
  tags = {
    Name = "${var.name}-VPC"
}
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.prod_vpc.id
  cidr_block = var.pub_cidir
  availability_zone = var.pub_az
  map_public_ip_on_launch =true

  tags = {
    Name = "${var.name}-pub-sub"
}
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.this.id
  cidr_block = var.prv_cidir
  availability_zone = var.prv_az
  tags = {
    Name = "${var.name}-prv-sub"
}
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
   tags = {
    Name = "${var.name}-igw"
}
}

resource "aws_eip" "nat" {
  vpc      = true
  tags = {
    Name = "${var.name}-eip"
}
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_subnet.id
  tags = {
    Name = "${var.name}-nat"
}
}

resource "aws_route_table" "pub_rt" {
  vpc_id = aws_vpc.this.id
  tags ={
    Name = "${var.name}-pub-rt"
}


  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

}

resource "aws_route_table_association" "pub_a" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.pub_rt.id
}

resource "aws_route_table" "prv_rt" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.name}-prv-rt"
}
 route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.ngw.id
  }

}

resource "aws_route_table_association" "prv_a" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.prv_rt.id
}
