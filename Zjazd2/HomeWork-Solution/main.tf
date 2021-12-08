provider "azurerm" {
  features {}
  ##TODO - sub id
  subscription_id = "c6484eee-b936-412a-94d6-8dc1b4386bc2"
}

##TODO - unikalna nazwa
data "azurerm_resource_group" "tf-st-rg60" {
  name = "tf-st-rg60"
}

#TODO - zmien RG
resource "azurerm_virtual_network" "hub-vnet01" {

  name                = "hub-vnet01"
  resource_group_name = data.azurerm_resource_group.tf-st-rg60.name
  location            = data.azurerm_resource_group.tf-st-rg60.location

  address_space = ["10.0.0.0/16"]

}

resource "azurerm_virtual_network" "spoke-vnet02" {

  name                = "spoke-vnet02"
  resource_group_name = data.azurerm_resource_group.tf-st-rg60.name
  location            = data.azurerm_resource_group.tf-st-rg60.location

  address_space = ["10.1.0.0/16"]

}

resource "azurerm_subnet" "hub-vnet01-subnet01" {
  name                 = "hub-vnet01-subnet01"
  virtual_network_name = azurerm_virtual_network.hub-vnet01.name
  resource_group_name  = data.azurerm_resource_group.tf-st-rg60.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "spoke-vnet02-subnet01" {
  name                 = "spoke-vnet02-subnet01"
  virtual_network_name = azurerm_virtual_network.spoke-vnet02.name
  resource_group_name  = data.azurerm_resource_group.tf-st-rg60.name
  address_prefixes     = ["10.1.0.0/24"]
}

resource "azurerm_virtual_network_peering" "hub-vnet01-to-spoke-vnet02" {
  name                         = "hub-vnet01-to-spoke-vnet02"
  resource_group_name          = data.azurerm_resource_group.tf-st-rg60.name
  virtual_network_name         = azurerm_virtual_network.hub-vnet01.name
  remote_virtual_network_id    = azurerm_virtual_network.spoke-vnet02.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  use_remote_gateways          = false
  allow_gateway_transit        = false
}

resource "azurerm_virtual_network_peering" "spoke-vnet02-to-hub-vnet01" {
  name                         = "spoke-vnet02-to-hub-vnet01"
  resource_group_name          = data.azurerm_resource_group.tf-st-rg60.name
  virtual_network_name         = azurerm_virtual_network.spoke-vnet02.name
  remote_virtual_network_id    = azurerm_virtual_network.hub-vnet01.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = false
  use_remote_gateways          = false
  allow_gateway_transit        = false
}