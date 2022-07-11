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

resource "azurerm_resource_group_policy_assignment" "policy-tags-assigment" {
  name                 = local.policy_assigment_tags_name
  resource_group_id    = data.azurerm_resource_group.rg.id
  policy_definition_id = azurerm_policy_definition.policy-tags.id
  description          = "Przypisanie polityki policy-tags do resource group"
  display_name         = local.policy_assigment_tags_name

  metadata = <<METADATA
        {
            "version":  "1.0.0",
            "category": "General"
        }
    METADATA

  parameters = <<PARAMETERS
        {
            "tagName": {
                "value": "my_tag"
            }
        }
    PARAMETERS
}