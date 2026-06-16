// Absolutely minimal policy based on AWS documentation
// Using the simplest possible structure

# Commented out to avoid multiple policy conflicts - only one policy attachment allowed per core network
/*
resource "aws_networkmanager_core_network_policy_attachment" "wan_policy_simple" {
  core_network_id = aws_networkmanager_core_network.wan_core_network.id
  policy_document = jsonencode({
    "version" = "2021.12"
    "core-network-configuration" = {
      "asn-ranges" = ["64512-65534"]
      "edge-locations" = [
        {
          "location" = "eu-central-1"
        },
        {
          "location" = "eu-north-1"  
        },
        {
          "location" = "ap-south-1"
        }
      ]
    }
    "segments" = [
      {
        "name" = "segment"
        "require-attachment-acceptance" = false
      }
    ]
    "attachment-policies" = [
      {
        "rule-number" = 1
        "condition-logic" = "or"
        "conditions" = [
          {
            "type" = "any"
          }
        ]
        "action" = {
          "association-method" = "constant"
          "segment" = "segment"
        }
      }
    ]
  })

  depends_on = [aws_networkmanager_core_network.wan_core_network]
}
*/
