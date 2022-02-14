terraform {
  backend "azurerm" {
    key = "network.tfstate"
  }
}
