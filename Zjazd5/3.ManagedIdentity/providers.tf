terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.8.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.12.0"
    }
  }
}

provider "azuread" {
  # Configuration options
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}