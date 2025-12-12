// Updated policy with multiple supported edge locations
// Based on AWS documentation for available regions

# Commented out to avoid multiple policy conflicts - only one policy attachment allowed per core network
/*
resource "aws_networkmanager_core_network_policy_attachment" "wan_policy_basic" {
  core_network_id = aws_networkmanager_core_network.wan_core_network.id
  policy_document = jsonencode({
    "version" = "2021.12"
    "core-network-configuration" = {
      "asn-ranges" = ["64512-65534"]
      "edge-locations" = [
        {
          "location" = "eu-central-1"    // Frankfurt
        },
        {
          "location" = "eu-north-1"      // Stockholm
        },
        {
          "location" = "us-east-1"       // Virginia (instead of Mumbai)
        }
      ]
    }
    "segments" = [
      {
        "name" = "shared"
        "require-attachment-acceptance" = false
      }
    ]
  })

  depends_on = [aws_networkmanager_core_network.wan_core_network]
}
*/
