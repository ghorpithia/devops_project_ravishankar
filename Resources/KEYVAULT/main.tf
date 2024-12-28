

data "azurerm_client_config" "bgp" {}

variable "mykeyvault" {
  type = map(object({
    mykeyvault = string
    location = string
    resource_group_name = string
  }))
}


resource "azurerm_key_vault" "mykeyvault" {
  for_each = var.mykeyvault
  name                        = each.value.mykeyvault
  location                    = each.value.location
  resource_group_name         = each.value.resource_group_name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.bgp.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.bgp.tenant_id
    object_id = data.azurerm_client_config.bgp.object_id

    key_permissions = [
      "Get","Create"
    ]

    secret_permissions = [
      "Get",
    ]

    storage_permissions = [
      "Get",
    ]
  }
}