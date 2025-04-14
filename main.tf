resource "azurerm_resource_group" "example" {
  name     = "example"
  location = "West Europe"
  project = "ravi-project"
  force_destroy = true
}
