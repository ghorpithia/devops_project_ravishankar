terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.12.0"
    }
  }
  #  backend "azurerm" {
  #   resource_group_name  = "RG-vnt-DEV-New"  # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
  #   storage_account_name = "savntfstate1"                      # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
  #   container_name       = "terraform"                       # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
  #   key                  = "terraform.tfstate"        # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  # }
}

provider "azurerm" {
  features {
    # key_vault {
    #   purge_soft_delete_on_destroy    = true
    #   recover_soft_deleted_key_vaults = true
    # }
  }
  subscription_id = "3557a350-5f75-450d-81dc-49e4d61a3ef5"
}