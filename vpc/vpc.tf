resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "myvpc"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "myigw"
  }
}

//count 2 runs the resource 2 times
resource "aws_subnet" "subnets" {
  count  = length(var.subnets_cidr)
  vpc_id = aws_vpc.main.id
  // meta character element(var.subnets_cidr, count.index)
  cidr_block        = element(var.subnets_cidr, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Subnet-${count.index + 1}"
  }
}

resource "aws_route_table" "publicRT" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "MyPublicRoute"
  }
}

resource "aws_route_table_association" "a" {
  count          = length(var.subnets_cidr)
  subnet_id      = element(aws_subnet.subnets.*.id, count.index)
  route_table_id = aws_route_table.publicRT.id
}
