terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.73.0"
    }
  }
}
provider "azurerm" {
  features {

  }

}
resource "azurerm_resource_group" "mangoliya" {
  name     = "niraj-rg"
  location = "West Europe"
}
resource "azurerm_resource_group" "rg" {
  for_each = var.storage_account

  name     = each.value.resource_group_name
  location = each.value.location
}


storage_accounts = {
  storage1 = {
    name                     = "vikstorage05"
    location                 = "japaneast"
    resource_group_name      = "milan"
    account_tier             = "Standard"
    account_replication_type = "LRS"

  }
}









resource "azurerm_storage_account" "storage_account" {
  for_each = var.storage_account

  name                     = each.value.name
  resource_group_name      = azurerm_resource_group.rg[each.key].name
  location                 = each.value.location
  account_tier             = each.value.account_tier
  account_replication_type = each.value.account_replication_type

  account_kind = "StorageV2"
}
