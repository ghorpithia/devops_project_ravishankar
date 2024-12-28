variable "akscluster1" {
  type = map(object({
    aksname = string
    location =string
    resource_group_name = string
  }))
}

resource "azurerm_kubernetes_cluster" "akscluster1" {
  for_each = var.akscluster1
  name                = each.value.aksname
  location            = each.value.location
  resource_group_name =each.value.resource_group_name
  dns_prefix          = "exampleaks5"

  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_D2_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Production"
  }
}

