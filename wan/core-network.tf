// create a core nework for all three regions with asn ranges 

resource "aws_networkmanager_core_network" "wan_core_network" {
  global_network_id = aws_networkmanager_global_network.wan_network.id
  description       = "Core Network for Stockholm, Mumbai, and Ireland"
  
  tags = {
    Name = "wan-core-network"
  }
}