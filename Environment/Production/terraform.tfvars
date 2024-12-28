rgvar = {
  rg1 = {
    resource_group_name = "myrg1"
    location            = "centralindia"
  }
}
vnet9 = {
  vnet9 = {
    vnet1               = "vnet1"
    location            = "centralindia"
    resource_group_name = "myrg1"
  }
}
acrrole = {
  acr1 = {
    acrname              = "acrgpt"
    resource_group_name  = "myrg1"
    location             = "centralindia"
    role_definition_name = "AcrPull"
    principal_aad_check  = true
    aksname              = "myaks1"
  }
}
aksghor = {
  aks1 = {
    aksname             = "myaks1"
    location            = "centralindia"
    resource_group_name = "myrg1"

  }
}

mysubnet5 = {
  mysubnet7 = {
    mysubnetname        = "mynewsubnet"
    resource_group_name = "myrg1"
    vnet1               = "vnet1"
    address_prefixes    = ["10.0.0.0/24"]
  }
}
nic1 = {
  mynic = {
    mynic               = "nic5"
    location            = "centralindia"
    resource_group_name = "myrg1"
    mysubnetname        = "mynewsubnet"
    vnet1               = "vnet1"
  }
}
mykeyvault49 = {
  mykeyvault = {
    mykeyvault          = "mynewkeyvault"
    location            = "centralindia"
    resource_group_name = "myrg1"
  }
}
labvm = {
  vm1 = {
    myvm1               = "hxsvm"
    location            = "centralindia"
    resource_group_name = "myrg1"
    mynic               = "nic5"
    # myusername ="ravijpuser"
    # secretvalue       = "ravijpuser"
    mypassword = "myvmpasswoed"
    mykeyvault = "mynewkeyvault"
  }
}