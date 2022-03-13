terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.95.0"
    }
  }
  backend "azurerm" {}
  required_version = "> 1.0.9"
}

provider "azurerm" {
  alias           = "spoke"
  subscription_id = var.app_subscription_id
  features {}
}
