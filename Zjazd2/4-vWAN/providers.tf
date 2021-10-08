terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 2.78.0"
    }
    azuread = {
      source = "hashicorp/azuread"
      version = "2.4.0"
    }
  }
}

provider "azurerm" {
  features { }
  subscription_id = "72ae933f-dab5-4a35-861e-1db14caba401"
}

provider "azuread" {
  tenant_id = "16dd9b56-84a8-4b26-b800-741b14debe2f"
}

# terraform import azurerm_storage_account.mz99storageacc /subscriptions/72ae933f-dab5-4a35-861e-1db14caba401/resourceGroups/LabRG/providers/Microsoft.Storage/storageAccounts/mz3213storageacc