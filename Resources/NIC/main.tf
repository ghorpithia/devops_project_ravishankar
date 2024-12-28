data "azurerm_subnet" "mysubnet1" {
  for_each = var.mynic
   name                 =each.value.mysubnetname
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.vnet1
}
variable "mynic" {
 type = map(object({
   mynic = string
   location = string
   resource_group_name = string
   mysubnetname = string
   vnet1 = string
 }))
}
resource "azurerm_network_interface" "mynic" {
    for_each = var.mynic
  name                = each.value.mynic
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = data.azurerm_subnet.mysubnet1[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}