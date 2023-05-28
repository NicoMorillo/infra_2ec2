resource "aws_route_table" "private" {
    count   = var.az_limit
    vpc_id = aws_vpc.vpc.id

    tags = {
        Name = "route_table_prv-${count.index + 1}"
    }
}

resource "aws_route_table_association" "private" {
  count          = var.az_limit
  route_table_id = element(aws_route_table.private.*.id, count.index)
  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
}

resource "aws_route" "outbound_to_nat" {
  count = var.az_limit
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway[count.index].id
}



resource "aws_route_table" "public" {
  count = var.az_limit  
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "route_table_pub-${count.index + 1}"
  }
}

resource "aws_route_table_association" "public" {
  count          = var.az_limit
  route_table_id = element(aws_route_table.public.*.id, count.index)
  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
}

resource "aws_route" "outbound_to_internet" {
  count = var.az_limit
  route_table_id         = element(aws_route_table.public.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.internet_gateway.id
}