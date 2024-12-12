terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.13.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "41070a7f-539b-404d-bc44-0fad46b020a5"

}

resource "azurerm_resource_group" "mydevopsrg" {
  name     = "mydevopsrg"
  location = "westeurope"
}
resource "azurerm_resource_group" "mydevopsrg1" {
  name     = "mydevopsrg1"
  location = "westeurope"
}

resource "azurerm_virtual_network" "mydevopsvnet"{
  name                = "mydevopsvnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.mydevopsrg.location
  resource_group_name = azurerm_resource_group.mydevopsrg.name
}

resource "azurerm_subnet" "mydevopssubnet" {
  name                 = "mydevopssubnet"
  resource_group_name  = azurerm_resource_group.mydevopsrg.name
  virtual_network_name = azurerm_virtual_network.mydevopsvnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "mydevopsnic" {
  name                = "mydevopsnic"
  location            = azurerm_resource_group.mydevopsrg.location
  resource_group_name = azurerm_resource_group.mydevopsrg.name

  ip_configuration {
    name                          = "mydevopssubnet"
    subnet_id                     = azurerm_subnet.mydevopssubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "mydevopsvm" {
  name                = "mydevopsvm"
  resource_group_name = azurerm_resource_group.mydevopsrg.name
  location            = azurerm_resource_group.mydevopsrg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "Ghorpithia@1994"
  network_interface_ids = [
    azurerm_network_interface.mydevopsnic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}