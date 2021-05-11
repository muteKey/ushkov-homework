resource "aws_vpc" "hometask6_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  tags = {
    Name = "${var.short_name}-vpc"
  }
}

resource "aws_subnet" "subnet_public" {
  count                   = length(var.public_subnets)
  vpc_id                  = aws_vpc.hometask6_vpc.id
  cidr_block              = element(var.public_subnets, count.index).cidr_block
  availability_zone       = element(var.public_subnets, count.index).availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.short_name}-public-subnet"
  }
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.hometask6_vpc.id
  tags = {
    Name = "${var.short_name}-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.hometask6_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
  lifecycle {
    ignore_changes = [route]
  }
  tags = {
    Name = "${var.short_name}-public-rt"
  }
}

resource "aws_route_table_association" "public_rt_association" {
  count          = length(var.public_subnets)
  subnet_id      = element(aws_subnet.subnet_public[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

