// creating 6 subnets in vpc 3 public subnets and 3 private subnets where each pun and private 

resource "aws_subnet" "public_subnet" {
  count                   = length(var.gives_cidr_to_public_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.gives_cidr_to_public_subnets[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name = "frank-Public-Subnet ${count.index + 1}"
  }

}

resource "aws_subnet" "private_subnet" {
  count                   = length(var.gives_cidr_to_private_subnets)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.gives_cidr_to_private_subnets[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = false
  tags = {
    Name = "frank-Private Subnet ${count.index + 1}"
  }

}
