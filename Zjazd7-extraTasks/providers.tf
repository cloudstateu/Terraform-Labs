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

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {
      resource_group {
        prevent_deletion_if_contains_resources = true
      }
  }
  subscription_id = "07db2bf6-3a2c-49b9-bdd4-6f6c43d02339"
 }

# Configure the Azure Active Directory Provider
provider "azuread" {
  tenant_id = "16dd9b56-84a8-4b26-b800-741b14debe2f"
}

# terraform import azurerm_storage_account.mz99storageacc /subscriptions/72ae933f-dab5-4a35-861e-1db14caba401/resourceGroups/LabRG/providers/Microsoft.Storage/storageAccounts/mz3213storageacc