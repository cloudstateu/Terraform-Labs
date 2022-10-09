terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.26.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.29.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "79283b62-f23b-4420-9ae7-1ac41de00335"
}

# Configure the Azure Active Directory Provider
provider "azuread" {
  tenant_id = "3a81269f-0731-42d7-9911-a8e9202fa750"
}
