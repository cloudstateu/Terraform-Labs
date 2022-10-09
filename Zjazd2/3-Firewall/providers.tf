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
  subscription_id = "79283b62-f23b-4420-9ae7-1ac41de00335"
}
