module "storage" {
  source = "../pko-storage"
  storage-account-name = var.storage-account-name
  storage-account-replication = var.storage-account-replication
  storage-account-rg = var.storage-account-rg
}

resource "azurerm_cdn_profile" "cdn-profile" {
  location            = module.storage.location
  name                = var.cdn-name
  resource_group_name = module.storage.resource-group-name
  sku                 = var.cdn-sku
}

