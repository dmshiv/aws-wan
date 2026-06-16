// Route tables for Stockholm with Cloud WAN routes

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.create_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.create_igw.id
  }

  # Route to Frankfurt Dev via Cloud WAN
  route {
    cidr_block      = "31.0.0.0/16"
    core_network_arn = data.terraform_remote_state.wan.outputs.core_network_arn
  }

  # Route to Virginia Shared via Cloud WAN
  route {
    cidr_block      = "51.0.0.0/16"
    core_network_arn = data.terraform_remote_state.wan.outputs.core_network_arn
  }

  tags = {
    Name = "stockholm-public-rt"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.create_vpc.id

  # Route to Frankfurt Dev via Cloud WAN
  route {
    cidr_block      = "31.0.0.0/16"
    core_network_arn = data.terraform_remote_state.wan.outputs.core_network_arn
  }

  # Route to Virginia Shared via Cloud WAN
  route {
    cidr_block      = "51.0.0.0/16"
    core_network_arn = data.terraform_remote_state.wan.outputs.core_network_arn
  }

  tags = {
    Name = "stockholm-private-rt"
  }
}
