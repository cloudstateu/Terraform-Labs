locals {
  suffix = "1002039"
  hashsuffix = substr(sha1("${var.subscription_id}${data.azurerm_resource_group.main_rg.name}"),0,5)

}

resource "azurerm_storage_account" "example" {
  #name                     = "sfysotrage1002039"
  name                     = "${var.images-storage-name}${local.hashsuffix}"
  resource_group_name      = data.azurerm_resource_group.main_rg.name
  location                 = data.azurerm_resource_group.main_rg.location
  account_tier             = "Standard"
  account_replication_type = "RAGRS"
  min_tls_version = "TLS1_2"
  allow_blob_public_access = "true"

  tags = {
    environment = "staging"
    creator = data.azuread_user.my_user_data.display_name
    deployment = "terraform"
  }
}

resource "azurerm_storage_container" "example" {
  depends_on = [azurerm_storage_account.example,azurerm_storage_container.images]
  name                  = "vhds"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "images" {
  name                  = "images"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

