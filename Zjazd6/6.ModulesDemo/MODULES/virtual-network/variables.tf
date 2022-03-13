variable "vnet_object" {

    description =<<EOF
Obiekt opisu obiekt typu VNET.
name:                   Nazwa Virtual Network
rg_name:                Nazwa Resource Group
address_space:          Adresacja dla Virtual Network
dns_servers:            Adresy serwerów DNS. Jeśli nie używamy własnego DNS, ustawiamy na 168.63.129.16
EOF
    type                = object({
        name            = string
        rg_name         = string
        address_space   = list(string)
        dns_servers     = list(string)    
    })
}
