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



resource "azurerm_virtual_network" "main" {
  name                = var.vpc_name
  resource_group_name = var.rg_name
  location            = var.region_vnet
  address_space       = [var.address_space_vnet]
}

resource "azurerm_subnet" "pb_sub" {
  name                 = var.pb_sub_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefix       = var.pb_sub_cidr
}

resource "azurerm_subnet" "pv_sub" {
  name                 = var.pv_sub_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefix       = var.pv_sub_cidr
}

resource "azurerm_public_ip" "rp_vm_pb_ip" {
  name                = var.rp_vm_ip_name
  location            = var.region_vnet
  resource_group_name = var.rg_name
  allocation_method   = var.rp_vm_pb_ip_allocation
}

resource "azurerm_public_ip" "nat_ip" {
  name                = var.nat_ip_name
  location            = var.region_vnet
  resource_group_name = var.rg_name
  allocation_method   = var.nat_pb_ip_allocation
  sku                 = var.nat_pb_ip_sku
  zones               = ["1"]
}

resource "azurerm_public_ip_prefix" "nat_ip_prefix" {
  name                = var.nat_ip_prefix_name
  location            = var.region_vnet
  resource_group_name = var.rg_name
  prefix_length       = var.nat_ip_prefix_length
  zones               = ["1"]
}

resource "azurerm_network_interface" "rp_ani" {
  name                = var.rp_ani_name
  location            = var.region_vnet
  resource_group_name = var.rg_name
  ip_configuration {
    name                          = var.rp_ani_ipconf
    subnet_id                     = azurerm_subnet.pb_sub.id
    private_ip_address_allocation = var.rp_vm_pv_ip_allocation
    public_ip_address_id          = azurerm_public_ip.rp_vm_pb_ip.id
  }
}

resource "azurerm_network_interface" "web_vm_01_ani" {
  name                = var.web_vm_01_ani_name
  location            = var.region_vnet
  resource_group_name = var.rg_name
  ip_configuration {
    name                          = var.web_vm_ani_ipconf
    subnet_id                     = azurerm_subnet.pv_sub.id
    private_ip_address_allocation = var.web_vm_pv_ip_allocation
    private_ip_address            = var.web_vm_01_pv_ip
  }
}

resource "azurerm_network_interface" "web_vm_02_ani" {
  name                = var.web_vm_02_ani_name
  location            = var.region_vnet
  resource_group_name = var.rg_name
  ip_configuration {
    name                          = var.web_vm_ani_ipconf
    subnet_id                     = azurerm_subnet.pv_sub.id
    private_ip_address_allocation = var.web_vm_pv_ip_allocation
    private_ip_address            = var.web_vm_02_pv_ip
  }
}


resource "azurerm_network_security_group" "pb_sub_sg" {
  name                = var.pb_sub_sg_name
  location            = var.region_vnet
  resource_group_name = var.rg_name
  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "HTTP"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "HTTPS"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "ping"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Icmp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "rp_vm_sg_association" {
  subnet_id                 = azurerm_subnet.pb_sub.id
  network_security_group_id = azurerm_network_security_group.pb_sub_sg.id
}

resource "azurerm_network_security_group" "pv_sub_sg" {
  name                = var.pv_sub_sg_name
  location            = var.region_vnet
  resource_group_name = var.rg_name
  security_rule {
    name                       = "Allow all"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nat_sg_association" {
  subnet_id                 = azurerm_subnet.pv_sub.id
  network_security_group_id = azurerm_network_security_group.pv_sub_sg.id
}

resource "azurerm_nat_gateway" "nat_gw" {
  name                    = var.nat_gw_name
  location                = var.region_vnet
  resource_group_name     = var.rg_name
  public_ip_address_ids   = [azurerm_public_ip.nat_ip.id]
  public_ip_prefix_ids    = [azurerm_public_ip_prefix.nat_ip_prefix.id]
  sku_name                = var.nat_gw_sku
  idle_timeout_in_minutes = var.nat_gw_timeout
  zones                   = ["1"]
}

resource "azurerm_subnet_nat_gateway_association" "nat_gw_pv_sub" {
  subnet_id      = azurerm_subnet.pv_sub.id
  nat_gateway_id = azurerm_nat_gateway.nat_gw.id
}
