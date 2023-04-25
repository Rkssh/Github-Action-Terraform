resource "azurerm_resource_group" "tf_github_action" {
  name     = "tf_github_action"
  location = "East US"
}

resource "azurerm_virtual_network" "azurevmn" {
  name                = "azurevn"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.tf_github_action.location
  resource_group_name = azurerm_resource_group.tf_github_action.name
}

resource "azurerm_subnet" "subnet-1" {
  name                 = "subnet-1"
  resource_group_name  = azurerm_resource_group.tf_github_action.name
  virtual_network_name = azurerm_virtual_network.azurevmn.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "public_ip"
  resource_group_name = azurerm_resource_group.tf_github_action.name
  location            = azurerm_resource_group.tf_github_action.location
  allocation_method   = "Static"

  tags = {
    environment = "Production"
  }
}

resource "azurerm_network_interface" "azurenic" {
  name                = "azurenic"
  location            = azurerm_resource_group.tf_github_action.location
  resource_group_name = azurerm_resource_group.tf_github_action.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet-1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

//Linux Virtual machine terraform script---------------------------------------------------------------->
resource "azurerm_linux_virtual_machine" "azurevm" {
  name                = "azurevm"
  resource_group_name = azurerm_resource_group.tf_github_action.name
  location            = azurerm_resource_group.tf_github_action.location
  size                = "Standard_DS2_v2_Promo"
  admin_username      = "adminuser"
  admin_password      = "Dipu$ingh123"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.azurenic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts"
    version   = "latest"
  }
}

output "public_ip" {
  value = azurerm_public_ip.public_ip.ip_address
}

//Endind of Linux virtual machine terraform script------------------------------------------------------>

# //Starting of windows virtual machine---------------------------------------->

# resource "azurerm_virtual_network" "win-network" {
#   name                = "win-network"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.tf_github_action.location
#   resource_group_name = azurerm_resource_group.tf_github_action.name
# }

# resource "azurerm_subnet" "subnet-2" {
#   name                 = "internal"
#   resource_group_name  = azurerm_resource_group.assigment_two.name
#   virtual_network_name = azurerm_virtual_network.win-network.name
#   address_prefixes     = ["10.0.2.0/24"]
# }

# resource "azurerm_network_interface" "win-nic" {
#   name                = "win-nic"
#   location            = azurerm_resource_group.assigment_two.location
#   resource_group_name = azurerm_resource_group.assigment_two.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.subnet-2.id
#     private_ip_address_allocation = "Dynamic"
#     public_ip_address_id = azurerm_public_ip.public_ip.id
#   }
# }

# resource "azurerm_windows_virtual_machine" "win-vm" {
#   name                = "win-machine"
#   resource_group_name = azurerm_resource_group.assigment_two.name
#   location            = azurerm_resource_group.assigment_two.location
#   size                = "Standard_DS2_v2_Promo"
#   admin_username      = "adminuser"
#   admin_password      = "P@$$w0rd1234!"
#   network_interface_ids = [
#     azurerm_network_interface.win-nic.id,
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "microsoftwindowsdesktop"
#     offer     = "windows-10"
#     sku       = "win10-21h2-pro"
#     version   = "latest"
#   }
# }