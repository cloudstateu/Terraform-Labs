terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.77.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.3.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "5b1dcd77-9361-42f2-8274-db430a1dd52e"
}

# Configure the Azure Active Directory Provider
provider "azuread" {
  tenant_id = "16dd9b56-84a8-4b26-b800-741b14debe2f"
}