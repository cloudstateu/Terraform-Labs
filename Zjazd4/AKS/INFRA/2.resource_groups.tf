resource "azurerm_resource_group" "global-net-rg" {
  name     = "global-net-rg"
  location = var.location
}

resource "azurerm_resource_group" "hub-net-rg" {
  name     = "hub-net-rg"
  location = var.location
}

resource "azurerm_resource_group" "dev-net-rg" {
  name     = "dev-net-rg"
  location = var.location
}

resource "azurerm_resource_group" "dev-prolab-rg" {
  count    = var.number-of-net
  name     = "dev-prolab${count.index}-rg"
  location = var.location
}

resource "azurerm_resource_group" "dev-dns-rg" {
  name     = "dev-dns-rg"
  location = var.location
}
