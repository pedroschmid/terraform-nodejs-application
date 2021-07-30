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
  subnet_id = aws_subnet.public[0].id

  depends_on = [
    aws_internet_gateway.nodejs
  ]

  tags = {
    "Name" = "nodejs-nat"
  }
}

