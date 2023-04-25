terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.53.0"
    }
  }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "tf_github_action"
    storage_account_name = "tfgitstorage"
    container_name       = "tfstate"
    key                  = "prod.terraform.tfstate"
  }
}


# provider "azurerm" {    
#   features {}

#   subscription_id = var.azure_subscription_id
#   tenant_id       = var.azure_tenant_id
#   client_id       = var.azure_client_id
#   client_secret   = var.azure_client_secret
# }

provider "azurerm" {    
  features {}
    subscription_id = var.AZURE_SUBSCRIPTION_ID
   tenant_id       = var.AZURE_TENANT_ID
   client_id       = var.AZURE_CLIENT_ID
   client_secret   = var.AZURE_CLIENT_SECRET
}