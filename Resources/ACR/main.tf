data "azurerm_kubernetes_cluster" "akscluster1" {
  for_each =  var.acrdetails
  name                = each.value.aksname
  resource_group_name = each.value.resource_group_name
}
data "azurerm_container_registry" "acr1" {
  for_each = var.acrdetails
  name                =  each.value.acrname
  resource_group_name = each.value.resource_group_name
}


variable "acrdetails" {
 type = map(object({
   acrname = string
   resource_group_name = string
   location = string
   role_definition_name   = string
   principal_aad_check = string
   aksname = string
 }))
}
resource "azurerm_container_registry" "acr1" {
  for_each = var.acrdetails
  name                = each.value.acrname
  resource_group_name = each.value.resource_group_name
  location            =each.value.location
  sku                 = "Premium"
  public_network_access_enabled = true
}



resource "azurerm_role_assignment" "acrrole" {
  for_each = var.acrdetails
  principal_id                     = data.azurerm_kubernetes_cluster.akscluster1[each.key].id
  role_definition_name             = each.value.role_definition_name
  scope                            = data.azurerm_container_registry.acr1[each.key].id
  skip_service_principal_aad_check = each.value.principal_aad_check
}