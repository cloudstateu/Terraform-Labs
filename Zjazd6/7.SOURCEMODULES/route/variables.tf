# NOTE: Wszystkie wartosci sa wymagane, dopiero w TF 0.14 mozliwa jest definicja optional attribute, czyli
# next_hop_in_ip_address    = optional(string)
# ale nawet w TF 0.14 jest to funkcjonalnosc eksperymentalna
variable "route_object" {
    description             = <<EOF
Obiekt definiujacy Route w Route Table.
route_name:                 Nazwa route w route table. 
route_table_name:           Nazwa route table. 
rg_name:                    Nazwa resource group.
address_prefix:             Prefix dla drogi w formacie 0-255.0-255.0-255.0-255/0-32 np. 10.13.0.0/16.
next_hop_type:              Rodzaj next hop, poprawne wartosci to VirtualNetworkGateway, VnetLocal, Internet, VirtualAppliance lub None.
next_hop_in_ip_address:     Adres IP next hop ma zastosowanie tylko jezeli next_hop_type jest ustawiony na VirtualAppliance, jezeli jest ustawiony inaczej nalezy podac null.
EOF

    type                    = object({
        route_name                = string
        route_table_name          = string
        rg_name                   = string
        address_prefix            = string
        next_hop_type             = string
        next_hop_in_ip_address    = string
    })

}
