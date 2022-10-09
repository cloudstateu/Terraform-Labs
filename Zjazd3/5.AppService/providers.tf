terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.26.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
