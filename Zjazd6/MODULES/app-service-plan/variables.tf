variable "app_service_object" {
    description = <<EOF
Obiekt definiujacy obiekt typu App Service
vnet_name:              Nazwa Virtual Network
subnet_name:            Nazwa subnet. 
vnet_rg_name:           Nazwa Resource Group, w ktorej jest Virtual Network
ase_name:               Nazwa App Service Environment
ase_rg_name:            Nazwa Resource Group, gdzie zostanie wdrozone App Service Environment
ase_tier:               ASE SKU moze przyjac wartosci: I1, I2 lub I3 w zaleznosci od wymagan wydajnosciowych
ase_front_scale_factor: Wspolczynnik skalowania front end. Moze przyjmowac wartosci z zakresu: 5 - 15
ase_vnet_endpoints:     Okresla, ktore endpointy ASE sa opubliowane w VNET. Ma zastosowanie tylko w przypadku wdrozenia poprzez Internal Load Balancer. 
ase_egress_ips:         Okresla adresy IP (w formie listy, ktore sa wykorzystywane jako egress
EOF

    type = object({
        vnet_name               = string
        subnet_name             = string
        vnet_rg_name            = string
        ase_name                = string
        ase_rg_name             = string
        ase_tier                = string
        ase_front_scale_factor  = number
        ase_vnet_endpoints      = string
        ase_egress_ips          = list(string)
    })
}
