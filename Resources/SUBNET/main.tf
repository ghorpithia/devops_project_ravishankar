variable "mysubnet1" {
  type = map(object({
    mysubnetname = string
    resource_group_name = string
    vnet1 = string
    address_prefixes = list(string)
  }))
}
resource "azurerm_subnet" "mysubnet1" {
  for_each = var.mysubnet1
  name                 =each.value.mysubnetname
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.vnet1
  address_prefixes     = each.value.address_prefixes

  # delegation {
  #   name = "delegation"

  #   service_delegation {
  #     name    = "Microsoft.ContainerInstance/containerGroups"
  #     actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action"]
  #   }
  # }
}