defaultlocation = "West Europe"

#SUB-06
dev-sub = "47e27356-5cc1-4aa4-9366-88a15c9bdff1"

#SUB-11
hub-sub = "c1f539c1-ae6b-4a40-99f0-de46ba25eaa7"

envprefix = "mf"

#RG - HUB
resource_group_object_rg_hub= {
        name                = "rg-hub-mf2"
        location            = "West Europe"
        lock_level          = "CanNotDelete"
}

resource_group_tags_rg_hub= {
        app                 = "app01"
        businessowner       = "mifurm"
        env                 = "prd"
        description         = "RG for HUB"
}

#RG - DEV
resource_group_object_rg_dev= {
        name                = "rg-dev-mf2"
        location            = "West Europe"
        lock_level          = "CanNotDelete"
}

resource_group_tags_rg_dev= {
        app                 = "app01"
        businessowner       = "mifurm"
        env                 = "dev"
        description         = "RG for APP01"
}

#RG - DEV
resource_group_object_rg_mon= {
        name                = "rg-mon-mf2"
        location            = "West Europe"
        lock_level          = "CanNotDelete"
}

resource_group_tags_rg_mon= {
        app                 = "app01"
        businessowner       = "mifurm"
        env                 = "mon"
        description         = "RG for APP01"
}