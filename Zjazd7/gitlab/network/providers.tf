terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.96.0"
    }
  }
  backend "http" {
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
