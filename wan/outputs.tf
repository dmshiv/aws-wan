// Output the core network information for regional folders to use

output "core_network_id" {
  description = "The ID of the AWS Network Manager core network"
  value       = aws_networkmanager_core_network.wan_core_network.id
}

output "core_network_arn" {
  description = "The ARN of the AWS Network Manager core network"
  value       = aws_networkmanager_core_network.wan_core_network.arn
}

output "global_network_id" {
  description = "The ID of the AWS Network Manager global network"
  value       = aws_networkmanager_global_network.wan_network.id
}
