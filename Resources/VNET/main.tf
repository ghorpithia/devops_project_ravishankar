variable "vnet1" {
  type = map(object({
    vnet1 = string
    location = string
    resource_group_name =string
  }))
}

resource "azurerm_virtual_network" "vnet1" {
  for_each = var.vnet1
  name                = each.value.vnet1
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  address_space       = ["10.0.0.0/16"]
  

 
}