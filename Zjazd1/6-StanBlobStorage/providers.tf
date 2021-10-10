terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.77.0"
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
  subscription_id = "72ae933f-dab5-4a35-861e-1db14caba401"
}
