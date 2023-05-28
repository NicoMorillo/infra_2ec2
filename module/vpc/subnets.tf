resource "aws_subnet" "public_subnets" {
  count      = var.az_limit

  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(cidrsubnet(aws_vpc.vpc.cidr_block, 8, 0), var.az_limit, count.index)
  availability_zone = data.aws_availability_zones.zones.names[count.index] # Define the 2 AZ per each subnet

  tags = {
    Name = "pub_sub-${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count      = var.az_limit

  vpc_id     = aws_vpc.vpc.id
  cidr_block = cidrsubnet(cidrsubnet(aws_vpc.vpc.cidr_block, 8, 1), var.az_limit, count.index)
  availability_zone = data.aws_availability_zones.zones.names[count.index] # Define the 2 AZ per each subnet

  tags = {
    Name = "priv_sub-${count.index + 1}"
  }
}