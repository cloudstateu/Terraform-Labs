variable "nsg_rule_object" {
    description             = <<EOF
Obiekt definiujacy regule w NSG.
nsg_name:                                      Nazwa NSG
rg_name:                                       Nazwa resource group
name:                                          Nazwa security rule w NSG
description:                                   Opis security rule w NSG
direction:                                     Kierunek dzialania reguly, mozliwe wartosci Inbound i Outbound
priority:                                      Priorytet reguly, moze przyjac wartosci od 100 do 4096. Priorytet musi byc unikalny
access:                                        Allow lub Deny dla reguly
protocol:                                      Protokol dla reguly, mozliwe wartosci Tcp, Udp, Icmp, lub * (czyli wszystkie protokoly)
source_address_prefix:                         Specyfikacja adresow zrodlowych, mozliwe wartosci to adres IP, IP range, * (aby okreslic any), lub jeden z tagow: VirtualNetwork, AzureLoadBalancer and Internet
source_port_range:                             Adres lub zakres portow zrodlowych, mozliwe wartosci liczba calkowita lub zakres pomiedzy 0 a 65535 lub *, aby okreslic any
destination_address_prefix:                    Specyfikacja adresow docelowych, mozliwe wartosci to adres IP, IP range, * (aby okreslic any), lub jeden z tagow: VirtualNetwork, AzureLoadBalancer and Internet. 
destination_port_range:                        Adres lub zakres portow docelowych, mozliwe wartosci liczba calkowita lub zakres pomiedzy 0 a 65535 lub *, aby okreslic any
source_application_security_group_ids:         Lista ID Application Security Group okreslajacych zrodlo, jezeli sa uzywane
destination_application_security_group_ids:    Lista ID Application Security Group okreslajacych cel, jezeli sa uzywane
EOF

    type                    = object({
        nsg_name                                    = string  
        rg_name                                     = string
        name                                        = string
        description                                 = string
        direction                                   = string
        priority                                    = number
        access                                      = string
        protocol                                    = string
        source_address_prefix                       = string
        source_port_range                           = string
        destination_address_prefix                  = string
        destination_port_range                      = string
        source_application_security_group_ids       = list(string)   
        destination_application_security_group_ids  = list(string) 
    })

}