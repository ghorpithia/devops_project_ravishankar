
variable "myvm1" {
  type = map(object({
    myvm1 = string
    location = string
    resource_group_name = string
    mynic = string
    # myusername =string
    # secretvalue       = string
mykeyvault = string
  }))
}

resource "azurerm_virtual_machine" "myvm1" {
  for_each = var.myvm1
  name                  = each.value.myvm1
  location              = each.value.location
  resource_group_name   = each.value.resource_group_name
  network_interface_ids = [data.azurerm_network_interface.mynic[each.key].id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = "adminvm"
    admin_password = azurerm_key_vault_secret.mypassword[each.key].value
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = {
    environment = "staging"
  }
}