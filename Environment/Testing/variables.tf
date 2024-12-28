variable "rgvar" {
  type = map(object({
    resource_group_name = string
    location            = string
  }))
}
variable "vnet9" {
  type = map(object({
    vnet1               = string
    location            = string
    resource_group_name = string
  }))
}
variable "acrrole" {
  type = map(object({
    acrname              = string
    resource_group_name  = string
    location             = string
    role_definition_name = string
    principal_aad_check  = string
    aksname              = string
  }))
}
variable "aksghor" {
  type = map(object({
    aksname             = string
    location            = string
    resource_group_name = string
  }))
}
variable "nic1" {
  type = map(object({
    mynic               = string
    location            = string
    resource_group_name = string
    mysubnetname        = string
    vnet1               = string
  }))
}
variable "mysubnet5" {
  type = map(object({
    mysubnetname        = string
    resource_group_name = string
    vnet1               = string
    address_prefixes    = list(string)
  }))
}
variable "mykeyvault49" {
  type = map(object({
    mykeyvault          = string
    location            = string
    resource_group_name = string
  }))
}
variable "labvm" {
  type = map(object({
    myvm1               = string
    location            = string
    resource_group_name = string
    mynic               = string
    # myusername =string
    # secretvalue       = string
mykeyvault = string
  }))
}
