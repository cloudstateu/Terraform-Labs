variable "route_table_object" {
    description = <<EOF
Obiekt definiujacy route
name                         : Nazwa route table
rg_name                      : Nazwa Resource Group
disable_bgp_route_propagation: Okreslenie czy do route table maja zostac dodane drogi propagowane przez BGP
EOF

    type                              = object({
        name                          = string
        rg_name                       = string
        disable_bgp_route_propagation = bool
    })
}
