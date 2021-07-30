resource "aws_vpc" "nodejs" {
  cidr_block           = var.VPC_CIDR_BLOCK
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "nodejs-vpc"
  }
}

resource "aws_subnet" "public" {
  count = length(var.PUBLIC_SUBNETS_CIDR)

  cidr_block        = element(var.PUBLIC_SUBNETS_CIDR, count.index)
  availability_zone = element(var.AVAILABILITY_ZONES, count.index)

  vpc_id = aws_vpc.nodejs.id

  tags = {
    "Name" = "nodejs-public-subnet"
  }
}

resource "aws_subnet" "private" {
  count = length(var.PRIVATE_SUBNETS_CIDR)

  cidr_block        = element(var.PRIVATE_SUBNETS_CIDR, count.index)
  availability_zone = element(var.AVAILABILITY_ZONES, count.index)

  vpc_id = aws_vpc.nodejs.id

  tags = {
    "Name" = "nodejs-private-subnet"
  }
}

resource "aws_internet_gateway" "nodejs" {
  vpc_id = aws_vpc.nodejs.id

  tags = {
    "Name" = "nodejs-igw"
  }
}

resource "aws_eip" "nodejs" {
  vpc = true

  depends_on = [
    aws_internet_gateway.nodejs
  ]

  tags = {
    "Name" = "nodejs-eip"
  }
}

resource "aws_nat_gateway" "nodejs" {
  allocation_id = aws_eip.nodejs.id
  subnet_id     = aws_subnet.public[0].id

  depends_on = [
    aws_internet_gateway.nodejs
  ]

  tags = {
    "Name" = "nodejs-nat"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.nodejs.id

  tags = {
    "Name" = "nodejs-public-route-table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.nodejs.id

  tags = {
    "Name" = "nodejs-private-route-table"
  }
}

resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  route_table_id = aws_route_table.public.id
  subnet_id      = element(aws_subnet.public.*.id, count.index)
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  route_table_id = aws_route_table.private.id
  subnet_id      = element(aws_subnet.private.*.id, count.index)
}

resource "aws_route" "public" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.nodejs.id
}

resource "aws_route" "private" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.private.id
  nat_gateway_id         = aws_nat_gateway.nodejs.id
}