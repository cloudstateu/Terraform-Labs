module "storageaccount-dev" {
  source = "./modules/storage"
  sa-name = "sa01devmf02"
  sa-location = "westeurope"
  rg-name = module.rg-vnets-test.name
}

output "sa-replication-type-storageaccount-dev" {
  value = module.storageaccount-dev.sa-replication-type  
}