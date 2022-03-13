# module "vnet-dev" {
#     source = "../MODULES/virtual-network"
#     vnet_object = {
#         name            = "vnet-dev"
#         rg_name         = module.rg-vnets-test.name
#         address_space   = ["10.0.0.0/16"]
#         dns_servers     = ["168.63.129.16"]
#     }
# }