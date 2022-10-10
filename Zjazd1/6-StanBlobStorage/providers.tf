terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.26.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "LabResourceGroup"
    storage_account_name = "mzterraformstacc"
    container_name       = "terraform"
    key                  = "terraform.tfstate"
    #access_key           = "" # Może być przetrzymywany przy pomocy zmiennej środowiskowej ARM_ACCESS_KEY
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  subscription_id = "79283b62-f23b-4420-9ae7-1ac41de00335"
}
