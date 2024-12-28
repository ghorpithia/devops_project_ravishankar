
data "azurerm_key_vault" "mykeyvault" {
  for_each = var.myvm1
  name                = each.value.mykeyvault
  resource_group_name = each.value.resource_group_name
}
# resource "azurerm_key_vault_secret" "username" {
#   for_each = var.myvm1
#   name         = each.value.myusername
#   value        = each.value.secretvalue
#   key_vault_id = data.azurerm_key_vault.mykeyvault[each.key].id
# }
resource "azurerm_key_vault_secret" "mypassword" {
  for_each = var.myvm1
  name         = "rvjp"
  value        = random_password.mypassword35.result
  key_vault_id = data.azurerm_key_vault.mykeyvault[each.key].id
}
resource "random_password" "mypassword35" {
  length           = 12
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}
data "azurerm_network_interface" "mynic" {
  for_each = var.myvm1
  name                = each.value.mynic
  resource_group_name = each.value.resource_group_name
}