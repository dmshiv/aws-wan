

// Create VPC attachment to the core network

resource "aws_networkmanager_vpc_attachment" "stockholm_vpc_attachment" {
  core_network_id = data.terraform_remote_state.wan.outputs.core_network_id
  vpc_arn         = aws_vpc.create_vpc.arn
  
  subnet_arns = [
    aws_subnet.public_subnet[0].arn,
    aws_subnet.public_subnet[1].arn,
    aws_subnet.public_subnet[2].arn
  ]

  tags = {
    env  = "production"
    Name = "stockholm-prod-vpc-attachment"
  }
}
