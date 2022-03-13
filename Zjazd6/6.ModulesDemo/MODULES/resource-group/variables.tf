variable "resource_group_object" {
    description             = <<EOF
Obiekt definiujacy Resource Group.
name:                        Nazwa Resource Group
location:                    Region Resource Group
lock_level:                  Okresla czy ma byc uzywany lock na poziomie RG. Mozliwe wartosci to: pusty string - brak locka, CanNotDelete - nie mozna usunac, ReadOnly - nie mozna zmodyfikowac.
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
description                 Tag description
businessowner:              Tag businessowner
env:                        Tag enviroment
description:                Tag moze przyjac wartosc pustego stringa lub stanowic dodatkowy opis dla Resource Group
EOF
    type                    = object({
        app                 = string
        businessowner       = string
        env                 = string
        description         = string
    })
}
