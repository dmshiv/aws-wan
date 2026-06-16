// 4 creating pub and private route tables 

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.create_igw.id
  }

  # Route to Stockholm Prod via Cloud WAN
  route {
    cidr_block      = "41.0.0.0/16"
    core_network_arn = data.terraform_remote_state.wan.outputs.core_network_arn
  }

  # Route to Virginia Shared via Cloud WAN  
  route {
    cidr_block      = "51.0.0.0/16"
    core_network_arn = data.terraform_remote_state.wan.outputs.core_network_arn
  }

  tags = {
    Name = "frankfurt-public-rt"
    env  = "development"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  # Route to Stockholm Prod via Cloud WAN
  route {
    cidr_block      = "41.0.0.0/16"
    core_network_arn = data.terraform_remote_state.wan.outputs.core_network_arn
  }

  # Route to Virginia Shared via Cloud WAN
  route {
    cidr_block      = "51.0.0.0/16"
    core_network_arn = data.terraform_remote_state.wan.outputs.core_network_arn
  }

  tags = {
    Name = "frankfurt-private-rt"
    env  = "development"
  }
}
