// lets create 2 separate segments for dev and prod for the core network 
// where it creates a policy shared can access dev and prod
// and dev and prod can access shared

// Temporarily removing policy to get core network working first
// Will add policy back once core network is stable

# resource "aws_networkmanager_core_network_policy_attachment" "wan_policy_version" {
#   core_network_id = aws_networkmanager_core_network.wan_core_network.id
#   policy_document = jsonencode({
#     version = "2021.12"
#     core_network_configuration = [
#       {
#         asn_ranges = ["64512-65534"]
#         edge_locations = [
#           {
#             location = "eu-central-1"
#             asn      = 64512
#           },
#           {
#             location = "eu-north-1"
#             asn      = 64513
#           },
#           {
#             location = "ap-south-1"
#             asn      = 64514
#           }
#         ]
#       }
#     ]
#     segments = [
#       {
#         name                          = "dev"
#         description                   = "Development segment"
#         require_attachment_acceptance = false
#       },
#       {
#         name                          = "prod"
#         description                   = "Production segment"
#         require_attachment_acceptance = false
#       },
#       {
#         name                          = "shared"
#         description                   = "Common segment for all regions"
#         require_attachment_acceptance = false
#       }
#     ]
#   })
#   depends_on = [aws_networkmanager_core_network.wan_core_network]
# }