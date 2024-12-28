variable "rgdetails" {
  type = map(object({
    resource_group_name = string
    location = string
  }))
}
resource "azurerm_resource_group" "rg1" {
  for_each = var.rgdetails
  name     = each.value.resource_group_name
  location = each.value.location
}