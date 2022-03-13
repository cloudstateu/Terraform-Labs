variable "peering_object" {

    description =<<EOF
Obiekt opisu obiekt typu VNET Peering.
vnet1_name:                     Nazwa pierwszego VNET
vnet1_rg_name:                  Nazwa Resource Group dla pierwszego VNET
vnet2_name:                     Nazwa drugiego VNET
vnet2_rg_name:                  Nazwa Resource Group dla pierwszego VNET
vnet_1_allow_forwarded_traffic: Ustawienie allow forwarded traffic dla pierwszego VNET   
vnet_1_use_remote_gateways:     Ustawienie use remote gateways dla pierwszego VNET   
vnet_1_allow_gateway_transit:   Ustawienie allow gateway transit dla pierwszego VNET
vnet_2_allow_forwarded_traffic: Ustawienie allow forwarded traffic dla drugiego VNET  
vnet_2_use_remote_gateways:     Ustawienie use remote gateways dla drugiego VNET   
vnet_2_allow_gateway_transit:   Ustawienie allow gateway transit dla drugiego VNET 

EOF
    type                = object({
        vnet1_name                      = string
        vnet1_rg_name                   = string
        vnet2_name                      = string
        vnet2_rg_name                   = string
        vnet_1_allow_forwarded_traffic  = bool
        vnet_1_use_remote_gateways      = bool
        vnet_1_allow_gateway_transit    = bool
        vnet_2_allow_forwarded_traffic  = bool
        vnet_2_use_remote_gateways      = bool
        vnet_2_allow_gateway_transit    = bool    
    })
}
