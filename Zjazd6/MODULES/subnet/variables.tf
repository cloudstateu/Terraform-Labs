
variable "subnet_object" {

    description = <<EOF
Obiekt definiujacy subnet
rg_name:                                Nazwa Resource Group
vnet_name:                              Nazwa Virtual Network
subnet_name:                            Nazwa subnetu
address_space:                          Adresacja dla subnet
private_link_endpoint_network_policies: Ustawienie wymuszenia NSG na Private Link Endpoint, jezeli wartosc wynosi false to w subnet nie mozna utworzyc Private Link Endpoint
private_link_service_network_policies:  Ustawienie wymuszenia NSG na Private Link Service, jezeli wartosc wynosi false to w subnet nie mozna utworzyc Private Link Service
service_endpoints:                      Lista Service Endpoints dla subnetu. Ustawiana tylko na zadanie osoby wdrazajacej projekt. 
service_endpoint_policy_ids:            Lista polityk dla Service Endpoints w subnet
route_table_id:                         Route Table ID, ktora ma zostac nalozona na subnet
nsg_id:                                 Network Security Group ID, ktora ma zostac nalozona na subnet
EOF

    type                                       = object({
        name                                   = string
        rg_name                                = string
        vnet_name                              = string
        address_space                          = list(string)
        private_link_endpoint_network_policies = bool
        private_link_service_network_policies  = bool
        service_endpoints                      = list(string)
        service_endpoint_policy_ids            = list(string)
        route_table_id                         = string
        nsg_id                                 = string
    })  
}


variable "subnet_delegation" {
    description = <<EOF
Lista obiektow do zdefiniowania delegacji subnetu do uslugi
object({
    name = object({
        name = string,
        actions = list(string)
    })
})
EOF

    type        = map(list(any))
    default     = {}
}
