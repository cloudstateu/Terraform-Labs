
locals {
  random_suffix_cdn = substr(sha1(format("%s/%s",var.subscription_id,azurerm_resource_group.cdn_rg.name)),0,5)
}
resource "azurerm_storage_account" "example" {
  name                     = format("%s%s","storagecdn",local.random_suffix_cdn)
  resource_group_name      = azurerm_resource_group.cdn_rg.name
  location                 = azurerm_resource_group.cdn_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  network_rules {
    default_action             = "Deny"
    virtual_network_subnet_ids = [azurerm_subnet.cdn-sub.id]
  }


  tags = {
    environment = "staging"
  }
}
resource "azurerm_cdn_profile" "example" {
  name                = "example-cdn"
  location            = azurerm_resource_group.cdn_rg.location
  resource_group_name = azurerm_resource_group.cdn_rg.name
  sku                 = "Standard_Verizon"
}

resource "azurerm_cdn_endpoint" "example" {
  name                = "example"
  profile_name        = azurerm_cdn_profile.example.name
  location            = azurerm_resource_group.cdn_rg.location
  resource_group_name = azurerm_resource_group.cdn_rg.name

  origin {
    name      = "example"
    host_name = azurerm_storage_account.example.primary_blob_host
  }
}