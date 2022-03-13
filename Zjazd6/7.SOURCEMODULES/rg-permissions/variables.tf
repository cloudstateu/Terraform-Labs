variable "rg_permission_object" {
    description             = <<EOF
rg_name:                     Nazwa Resource Group
principal_id:                Object ID konta, grupy lub Service Principal w Azure AD
builtin_roles:               Lista ról wbudowanych nadawanych na rg_name dla principal_id.
custom_roles:                Lista ról customowych nadawanych na rg_name dla principal_id.
EOF

    type                    = object({
        rg_name                   = string
        principal_id              = string
        builtin_roles             = list(string)
        custom_roles              = list(string)
    })
}