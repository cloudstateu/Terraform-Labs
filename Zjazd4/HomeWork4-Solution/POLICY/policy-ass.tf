resource "azurerm_policy_assignment" "polasg-mf-chm-allowedlocations" {
  name                 = "polasg-mf-chm-allowedlocations"
  scope                = "/subscriptions/${var.subscription-id}/resourceGroups/rg-jenkins"
  policy_definition_id = azurerm_policy_definition.mf-chm-allowedlocations.id
  description          = "Przypisanie polityki mf-chm-allowedlocations do subskrypcji"
  display_name         = "polasg-mf-chm-allowedlocations"
  enforcement_mode     = "true"

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

resource "azurerm_storage_account" "naeweweme" {
  name                     = "naeweweme"
  resource_group_name      = "rg-jenkins"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_storage_account" "nae32423423weweme" {
  name                     = "nae32423423weweme"
  resource_group_name      = "rg-jenkins"
  location                 = "eastus"
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}

