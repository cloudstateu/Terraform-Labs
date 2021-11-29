variable "resource_group_object" {
    description             = <<EOF
Obiekt Resource Group.
name:                        Nazwa Resource Group
location:                    Region Resource Group
lock_level:                  Lock
EOF

    type                    = object({
        name                = string
        location            = string
        lock_level          = string
    })
}

variable "resource_group_tags" {

    description             = <<EOF
Obiekt definiujacy tagi przypisywane do Resource Group
app:                        Tag app
businessowner:              Tag businessowner
env:                        Tag env, moze przyjmowac wartosci 
description:                Tag moze przyjac wartosc pusta lub opis
EOF
    type                    = object({
        app                 = string
        businessowner       = string
        env                 = string
        description         = string
    })
}

