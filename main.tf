terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.ARM_SUBSCRIPTION_ID
  tenant_id       = var.ARM_TENANT_ID
  client_id       = var.ARM_CLIENT_ID
  client_secret   = var.ARM_CLIENT_SECRET
}

module "rg" {
  source = "./rg"
}

module "vnet" {
  source  = "./vnet"
  rg_name = module.rg.rg_name
}

module "vms" {
  source       = "./vms"
  rg_name      = module.rg.rg_name
  rp_ani_id    = module.vnet.rp_ani_id
  web01_ani_id = module.vnet.web01_ani_id
  web02_ani_id = module.vnet.web02_ani_id
}

