// AWS WAN Policy - Hub and Spoke Topology
// Shared (hub) can communicate with Dev and Prod
// Dev and Prod cannot communicate with each other

resource "aws_networkmanager_core_network_policy_attachment" "wan_policy_custom" {
  core_network_id = aws_networkmanager_core_network.wan_core_network.id
  policy_document = jsonencode({
    "version" = "2021.12"
    "core-network-configuration" = {
      "asn-ranges" = ["64512-65534"]
      "edge-locations" = [
        {
          "location" = "eu-central-1"    # Frankfurt
          "asn" = 64512
        },
        {
          "location" = "eu-north-1"      # Stockholm
          "asn" = 64513
        },
        {
          "location" = "us-east-1"       # Virginia (temporary until Mumbai)
          "asn" = 64514
        }
      ]
    }
    
    "segments" = [
      {
        "name" = "shared"
        "description" = "Shared hub segment"
        "require-attachment-acceptance" = false
      },
      {
        "name" = "dev"
        "description" = "Development segment"
        "require-attachment-acceptance" = false
      },
      {
        "name" = "prod"
        "description" = "Production segment"
        "require-attachment-acceptance" = false
      }
    ]

    "segment-actions" = [
      {
        "action" = "share"
        "mode" = "attachment-route"
        "segment" = "shared"
        "share-with" = ["dev", "prod"]
      },
      {
        "action" = "share"
        "mode" = "attachment-route"
        "segment" = "dev"
        "share-with" = ["shared"]
      },
      {
        "action" = "share"
        "mode" = "attachment-route"
        "segment" = "prod"
        "share-with" = ["shared"]
      }
    ]

    "attachment-policies" = [
      {
        "rule-number" = 100
        "condition-logic" = "or"
        "conditions" = [
          {
            "type" = "tag-value"
            "operator" = "equals"
            "key" = "env"
            "value" = "shared"
          }
        ]
        "action" = {
          "association-method" = "constant"
          "segment" = "shared"
        }
      },
      {
        "rule-number" = 1
        "condition-logic" = "or"
        "conditions" = [
          {
            "type" = "tag-value"
            "operator" = "equals"
            "key" = "env"
            "value" = "development"
          }
        ]
        "action" = {
          "association-method" = "constant"
          "segment" = "dev"
        }
      },
      {
        "rule-number" = 2
        "condition-logic" = "or"
        "conditions" = [
          {
            "type" = "tag-value"
            "operator" = "equals"
            "key" = "env"
            "value" = "production"
          }
        ]
        "action" = {
          "association-method" = "constant"
          "segment" = "prod"
        }
      }
    ]
  })

  depends_on = [aws_networkmanager_core_network.wan_core_network]
}
