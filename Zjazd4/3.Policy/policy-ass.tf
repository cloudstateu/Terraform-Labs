resource "azurerm_resource_group_policy_assignment" "policy-locations-assigment" {
  name                 = local.policy_assigment_name
  resource_group_id    = data.azurerm_resource_group.rg.id
  policy_definition_id = azurerm_policy_definition.policy-locations.id
  description          = "Przypisanie polityki policy-locations do resource group"
  display_name         = local.policy_assigment_name

  metadata = <<METADATA
        {
            "version":  "1.0.0",
            "category": "General"
        }
    METADATA

  parameters = <<PARAMETERS
        {
            "listOfAllowedLocations": {
                "value": [
                    "westeurope",
                    "northeurope"
                ]
            }
        }
    PARAMETERS
}

resource "azurerm_resource_group_policy_assignment" "policy-vm-sizes-assigment" {
  name                 = local.policy_assigment_sizes_name
  resource_group_id    = data.azurerm_resource_group.rg.id
  policy_definition_id = azurerm_policy_definition.policy-vm-sizes.id
  description          = "Przypisanie polityki policy-vm-sizes do resource group"
  display_name         = local.policy_assigment_sizes_name

  metadata = <<METADATA
        {
            "version":  "1.0.0",
            "category": "General"
        }
    METADATA

  parameters = <<PARAMETERS
        {
            "listOfAllowedSKUs": {
                "value": ["D2as_v5"]
            }
        }
    PARAMETERS
}
