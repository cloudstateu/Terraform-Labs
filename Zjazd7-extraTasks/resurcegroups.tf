# primary for network and other things
resource "azurerm_resource_group" "networking_rg" {
  name                     = "networking_rg"
  location                 = "West Europe"

  tags = {
    environment = "dev"
    owner = "pdw"
  }
}

# redis
resource "azurerm_resource_group" "redis_rg" {
  name                     = "redis_rg"
  location                 = "West Europe"

  tags = {
    environment = "dev"
    owner = "pdw"
  }
}

# legacy vms
resource "azurerm_resource_group" "legacy_rg" {
  name                     = "legacy_rg"
  location                 = "West Europe"

  tags = {
    environment = "dev"
    owner = "pdw"
  }
}

# app services env
resource "azurerm_resource_group" "ase_rg" {
  name                     = "ase_rg"
  location                 = "West Europe"

  tags = {
    environment = "dev"
    owner = "pdw"
  }
}

# postgres
resource "azurerm_resource_group" "pg_rg" {
  name                     = "pg_rg"
  location                 = "West Europe"

  tags = {
    environment = "dev"
    owner = "pdw"
  }
}

# cdn
resource "azurerm_resource_group" "cdn_rg" {
  name                     = "cdn_rg"
  location                 = "West Europe"

  tags = {
    environment = "dev"
    owner = "pdw"
  }
}