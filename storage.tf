# resource "azurerm_storage_account" "storageji" {
#   name                     = "storageji"
#   resource_group_name      = azurerm_resource_group.variprojects.name
#   location                 = azurerm_resource_group.variprojects.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"

#   tags = {
#     environment = "staging"
#   }
# }

# resource "azurerm_storage_container" "terrastorage" {
#   name                  = "terrastorage"
#   storage_account_name  = azurerm_storage_account.storageji.name
#   container_access_type = "private"
# }
