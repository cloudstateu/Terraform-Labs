module "storageaccount-dev" {
  source = "./modules/storage"
  sa-name = "sa01dev"
  sa-location = "westeurope"
  rg-name = module.rg-vnets-test.name
}