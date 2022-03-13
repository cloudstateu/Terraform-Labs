variable "principal_object" {
    description             = <<EOF
Obiekt definiujacy nadawanie uprawnien na User, Group lub SP.
name:                        Nazwa Service Principal
type:                        Rodzaj service principal moze przyjac wartosc: User, Group, SP
rg_name:                     Nazwa resource group, na której są nadawane uprawnienia. Jeżeli zostanie pozostawione puste to uprawnienia nie będą nadawane.
vnet_rg_name:                Nazwa resource group, w której jest VNET.
vnet_name:                   Nazwa Virtual Network, na której są nadawane uprawnienia. Jeżeli zostanie pozostawione puste to uprawnienia nie będą nadawane.
subnet_name:                 Nazwa Subnet, na którym są nadawane uprawnienia. Jeżeli zostanie pozostawione puste to uprawnienia nie będą nadawane. UWAGA!!! 
builtin_roles:               Lista ról wbudowanych nadawanych na Service Principal.
custom_roles:                Lista ról customowych nadawanych na Service Principal.
EOF

    type                    = object({
        name                      = string
        certificate_type          = string
        public_certificate_path   = string
        start_date                = string
        end_date                  = string
        end_date_relative         = string
        rg_name                   = string
        builtin_roles             = list(string)
        custom_roles              = list(string)
    })

}