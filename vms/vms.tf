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

resource "tls_private_key" "vms_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "azurerm_storage_account" "bootdiagnosticsrp" {
  name                     = var.asa_rp_vm_name
  location                 = var.region_vms
  resource_group_name      = var.rg_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

data "template_file" "rp_vm_bootstrapscript" {
  template = file("${path.module}/bssrp.sh")
}

resource "azurerm_linux_virtual_machine" "rp_vm" {
  name                  = var.rp_vm_name
  location              = var.region_vms
  resource_group_name   = var.rg_name
  network_interface_ids = [var.rp_ani_id]
  size                  = "Standard_DC1s_v3"
  os_disk {
    name                 = var.rp_vm_os_disk_name
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18_04-lts-gen2"
    version   = "latest"
  }
  computer_name                   = var.rp_vm_computer_name
  admin_username                  = var.rp_vm_adm_user
  disable_password_authentication = true
  admin_ssh_key {
    username   = var.rp_vm_adm_user
    public_key = tls_private_key.vms_ssh.public_key_openssh
  }
  custom_data = base64encode(data.template_file.rp_vm_bootstrapscript.rendered)
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.bootdiagnosticsrp.primary_blob_endpoint
  }
}

resource "azurerm_storage_account" "bootdiagnosticsweb01" {
  name                     = var.asa_web01_vm_name
  location                 = var.region_vms
  resource_group_name      = var.rg_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


data "template_file" "web01_vm_bootstrapscript" {
  template = file("${path.module}/bssweb01.sh")
}

resource "azurerm_linux_virtual_machine" "web01_vm" {
  name                  = var.web01_vm_name
  location              = var.region_vms
  resource_group_name   = var.rg_name
  network_interface_ids = [var.web01_ani_id]
  size                  = "Standard_DC1s_v3"
  os_disk {
    name                 = var.web01_vm_os_disk_name
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18_04-lts-gen2"
    version   = "latest"
  }
  computer_name                   = var.web01_vm_computer_name
  admin_username                  = var.web01_vm_adm_user
  disable_password_authentication = true
  admin_ssh_key {
    username   = var.web01_vm_adm_user
    public_key = tls_private_key.vms_ssh.public_key_openssh
  }
  custom_data = base64encode(data.template_file.web01_vm_bootstrapscript.rendered)
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.bootdiagnosticsweb01.primary_blob_endpoint
  }
}

resource "azurerm_storage_account" "bootdiagnosticsweb02" {
  name                     = var.asa_web02_vm_name
  location                 = var.region_vms
  resource_group_name      = var.rg_name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


data "template_file" "web02_vm_bootstrapscript" {
  template = file("${path.module}/bssweb02.sh")
}

resource "azurerm_linux_virtual_machine" "web02_vm" {
  name                  = var.web02_vm_name
  location              = var.region_vms
  resource_group_name   = var.rg_name
  network_interface_ids = [var.web02_ani_id]
  size                  = "Standard_DC1s_v3"
  os_disk {
    name                 = var.web02_vm_os_disk_name
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18_04-lts-gen2"
    version   = "latest"
  }
  computer_name                   = var.web02_vm_computer_name
  admin_username                  = var.web02_vm_adm_user
  disable_password_authentication = true
  admin_ssh_key {
    username   = var.web02_vm_adm_user
    public_key = tls_private_key.vms_ssh.public_key_openssh
  }
  custom_data = base64encode(data.template_file.web02_vm_bootstrapscript.rendered)
  boot_diagnostics {
    storage_account_uri = azurerm_storage_account.bootdiagnosticsweb02.primary_blob_endpoint
  }
}

resource "local_file" "private_pem" {
  filename = "${path.root}/id_rsa"
  content  = tls_private_key.vms_ssh.private_key_pem
}
