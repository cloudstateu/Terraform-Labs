variable "nsg_object" {
    description = <<EOF
Obiekt definiujacy obiekt typu NSG
name:       Nazwa NSG
rg_name:    Nazwa Resource Group
EOF

    type = object({
        name = string
        rg_name = string 
    })
}
