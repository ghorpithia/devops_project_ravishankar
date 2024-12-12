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
resource "azurerm_resource_group" "devopsrg" {
  name     = "devopsrg"
  location = "West Europe"
}
resource "azurerm_resource_group" "devopsrg1" {
  name     = "devopsrg1"
  location = "West Europe"
}

resource "azurerm_virtual_network" "devopsvnet" {
  depends_on          = [azurerm_resource_group.devopsrg]
  name                = "devopsvnet"
  address_space       = ["10.0.0.0/16"]
  location            = "West Europe"
  resource_group_name = "devopsrg"
}

resource "azurerm_subnet" "devopssubnet" {
    depends_on = [ azurerm_resource_group.devopsrg, azurerm_virtual_network.devopsvnet ]
  name                 = "devopsinternal"
  resource_group_name  = "devopsrg"
  virtual_network_name = "devopsvnet"
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "devopsnic" {
  depends_on          = [azurerm_virtual_network.devopsvnet]
  name                = "devopsnic"
  location            = "West Europe"
  resource_group_name = "devopsrg"

  ip_configuration {
    name                          = "devopsinternalname"
    subnet_id                     = azurerm_subnet.devopssubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "devopsvm" {
  depends_on            = [azurerm_virtual_network.devopsvnet]
  name                  = "devopsvm"
  resource_group_name   = "devopsrg"
  location              = "West Europe"
  size                  = "Standard_F2"
  admin_username        = "adminuser"
  admin_password        = "Ghorpithia@1994"
  network_interface_ids = [azurerm_network_interface.devopsnic.id]


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