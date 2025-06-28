resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr

  tags = {
    Name    = "main-vpc"
    Project = "aws-alb-autoscaling-terraform"
    Owner   = "André Santos"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name    = "main-igw"
    Project = "aws-alb-autoscaling-terraform"
    Owner   = "André Santos"
  }
}

resource "aws_subnet" "public" {
  for_each = zipmap(var.azs, var.public_subnets)

  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  availability_zone       = each.key
  map_public_ip_on_launch = true

  tags = {
    Name    = "public-subnet-${each.key}"
    Project = "aws-alb-autoscaling-terraform"
    Owner   = "André Santos"
  }
}

resource "aws_subnet" "private" {
  for_each = zipmap(var.azs, var.private_subnets)

  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = each.key

  tags = {
    Name    = "private-subnet-${each.key}"
    Project = "aws-alb-autoscaling-terraform"
    Owner   = "André Santos"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name    = "public-route-table"
    Project = "aws-alb-autoscaling-terraform"
    Owner   = "André Santos"
  }
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name    = "main-nat-eip"
    Project = "aws-alb-autoscaling-terraform"
    Owner   = "André Santos"
  }
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = values(aws_subnet.public)[0].id

  tags = {
    Name    = "main-nat-gateway"
    Project = "aws-alb-autoscaling-terraform"
    Owner   = "André Santos"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name    = "private-route-table"
    Project = "aws-alb-autoscaling-terraform"
    Owner   = "André Santos"
  }
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}
