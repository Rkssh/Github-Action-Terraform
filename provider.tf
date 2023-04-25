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


provider "azurerm" {
  features {}
}
