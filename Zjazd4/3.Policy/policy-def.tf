resource "azurerm_policy_definition" "policy-locations" {
  name         = local.policy_name
  display_name = local.policy_name
  policy_type  = "Custom"
  mode         = "Indexed"
  description  = "Polityka wymuszająca tworzenie zasobów w określonym regionie."

  metadata = <<METADATA
  {
    "version":  "1.0.0",
    "category": "General"
  }
  METADATA


  policy_rule = <<POLICY_RULE
    {
        "if": {
            "allOf": [
            {
                "field": "location",
                "notIn": "[parameters('listOfAllowedLocations')]"
            },
            {
                "field": "location",
                "notEquals": "global"
            },
            {
                "field": "type",
                "notEquals": "Microsoft.AzureActiveDirectory/b2cDirectories"
            }
            ]
        },
        "then": {
            "effect": "deny"
        }
    }
POLICY_RULE


  parameters = <<PARAMETERS
    {
        "listOfAllowedLocations": {
            "type": "Array",
            "metadata": {
                "description": "The list of locations that can be specified when deploying resources.",
                "strongType": "location",
                "displayName": "Allowed locations"
            }
        }
    }
PARAMETERS

}

locals {
  policy = jsondecode(file("./VMSkusAllowed_Deny.json"))
}

resource "azurerm_policy_definition" "policy-vm-sizes" {
  name         = local.policy_tags_name
  display_name = local.policy_tags_name
  policy_type  = "Custom"
  mode         = "Indexed"
  description  = "Polityka wymusza tworzenie wirtualnych maszyn tylko w określonych rozmiarach."
  metadata     = jsonencode(local.policy.properties.metadata)
  policy_rule  = jsonencode(local.policy.properties.policyRule)
  parameters   = jsonencode(local.policy.properties.parameters)
}
