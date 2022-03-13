data "azurerm_resource_group" "mygroup" {
  name = "LabSFY"
}

module "project-x-storage-images" {
  source = "./modules/pko-storage"
  storage-account-name = "tomek123gjfs"
  storage-account-rg = data.azurerm_resource_group.mygroup.name
  storage-account-replication = "GRS"
}

module "project-x-storage-invoices" {
  source = "./modules/pko-storage"
  storage-account-name = "tomek13invoices"
  storage-account-rg = data.azurerm_resource_group.mygroup.name
  storage-account-replication = "GRS"
}

resource "azurerm_storage_container" "rawinvoices" {
  name                 = "rawinvoices"
  storage_account_name = module.project-x-storage-invoices.storage-account-name
}


module "project-x-storage-cdn" {
  source = "./modules/pko-cdn"
  storage-account-name = "cdnstatic123gffg"
  storage-account-rg = data.azurerm_resource_group.mygroup.name
  storage-account-replication = "GRS"
  cdn-name = "pkocdnstatic123"
  cdn-sku = "Standard_Verizon"
}

module "project-x-kv" {
  source = "./modules/pko-keyvault"
  key-vault-name = "mykv123projectx"
  resource-group-name = data.azurerm_resource_group.mygroup.name
}


module "network" {
  source              = "Azure/network/azurerm"
  resource_group_name = data.azurerm_resource_group.mygroup.name
  address_spaces      = ["10.0.0.0/16", "10.2.0.0/16"]
  subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  subnet_names        = ["subnet1", "subnet2", "redis-subnet"]

  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}

module "project-x-redis" {
  source = "./modules/pko-redis"

  redis-name          = "myredis123x"
  redis-subnet-id     = module.network.vnet_subnets[2]
  resource-group-name = data.azurerm_resource_group.mygroup.name
}


/*
1. VNET z modułu "Azure/network/azurerm"
a. 2 subnety

2. napiszcie moduł do Redisa
b. tworzyć w wersji Premium (sku P)
c. wpięty w subnet o nazwie redis-subnet który utworzyliście modułem z punktu 1
*/