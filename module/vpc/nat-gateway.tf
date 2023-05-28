resource "aws_eip" "nat_eip" {
  count = var.az_limit
  domain = "vpc"
  
  tags = {
    Name = "eip-${count.index + 1}"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count = var.az_limit
  allocation_id = element(aws_eip.nat_eip.*.id, count.index)
  subnet_id     = element(aws_subnet.public_subnets.*.id, count.index)

  tags = {
    Name = "nat-${count.index + 1}"
  }
}

