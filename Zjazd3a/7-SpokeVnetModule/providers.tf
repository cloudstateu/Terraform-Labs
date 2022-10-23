terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.28.0"
    }
  }
}

provider "azurerm" {
  alias           = "hub"
  features {}
  subscription_id = var.hub_subscription_id
}

provider "azurerm" {
  alias           = "spoke"
  features {}
  subscription_id = var.spoke_subscription_id
}
