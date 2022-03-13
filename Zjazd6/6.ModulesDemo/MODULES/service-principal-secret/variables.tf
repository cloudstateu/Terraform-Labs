variable "service_principal_object" {
    description             = <<EOF
Obiekt definiujacy Service Principal.
name:                        Nazwa Service Principal
password:                    Haslo do Service Principal, inna nazwa to secret
start_date:                  Data od kiedy mozna uzywac certyfikatu dla Service Principal, w formacie RFC3339, czyli: 2022-01-09T01:02:03Z, ustawiajac na pusty string bedzie brana dzisiejsza data
end_date:                    Okres przez jaki mozna korzystac z certyfikatu dla Service Principal, w formacie RFC3339, czyli: 2022-01-09T01:02:03Z
end_date_relative:           Okres przez jaki mozna korzystac z certyfikatu dla Service Principal, ta wartosc jest dodawana do service_principal_start_date, format to XXXh co oznacza XXX godzin. Maksymalnie mozna ustawic na 8736h
rg_name:                     Nazwa resource group, na której są nadawane uprawnienia. Jeżeli zostanie pozostawione puste to nie uprawnienia nie będą nadawane.
builtin_roles:               Lista ról wbudowanych nadawanych na Service Principal.
custom_roles:                Lista ról customowych nadawanych na Service Principal.
EOF

    type                    = object({
        name                      = string
        password                  = string
        start_date                = string
        end_date                  = string
        end_date_relative         = string
        rg_name                   = string
        builtin_roles             = list(string)
        custom_roles              = list(string)
    })

}