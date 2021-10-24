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

#TODO: mifurm, dodaje providera RAND by generowac unikalne nazwy
#TODO: slaby pomysl na produkcje ale tutaj przydaje sie by nie generowac tych samych nazw
provider "random" {

}