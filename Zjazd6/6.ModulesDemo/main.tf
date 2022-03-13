provider "azurerm" {
  subscription_id = "ffca029c-a6e3-4630-9dfc-ff43256cd2f8"
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}

provider "azuread" {
  # Configuration options
}

resource "azurerm_resource_group" "module01-rg" {
    name = "module01-rg"
    location = "West Europe"
}