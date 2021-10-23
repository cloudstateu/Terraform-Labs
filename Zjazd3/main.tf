terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.78.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.sub-id
}