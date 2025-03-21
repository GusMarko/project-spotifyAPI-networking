# basic vpc setup, public and private subnets, internet and nat gateway

resource "aws_vpc" "main" {
  cidr_block       = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "vpc-${var.env}"
    Environment = "${var.env}"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.pub_sub_cidr
  map_public_ip_on_launch = false


  tags = {
    Name = "pub-sub-${var.env}"
    Environment = "${var.env}"
  }
}

resource "aws_subnet" "private" {
  vpc_id = aws_vpc.main.id
  cidr_block = var.priv_sub_cidr

  tags = {
    Name = "priv-sub-${var.env}"
    Environment = "${var.env}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

   tags = {
    Name = "pub-rt-${var.env}"
    Environment = "${var.env}"
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"           
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "priv-rt-${var.env}"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-${var.env}"
    Environment = "${var.env}"
  }
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = "nat-${var.env}"
    Environment = "${var.env}"
  }

  depends_on = [aws_internet_gateway.igw]
}

resource "aws_eip" "eip" {
  domain   = "vpc"
} 