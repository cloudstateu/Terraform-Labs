


resource "azurerm_app_service_environment" "ase1" {
  name                         = "ease1"
 # location  = azurerm_resource_group.ase_rg.location
  subnet_id                    = azurerm_subnet.ase-sub.id
  resource_group_name = azurerm_resource_group.ase_rg.name
  pricing_tier                 = "I2"
  front_end_scale_factor       = 10
  internal_load_balancing_mode = "Web, Publishing"
#  allowed_user_ip_cidrs        = ["11.22.33.44/32", "55.66.77.0/24"]

  cluster_setting {
    name  = "DisableTls1.0"
    value = "1"
  }
}