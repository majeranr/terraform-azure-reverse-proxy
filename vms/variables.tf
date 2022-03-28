variable "ARM_SUBSCRIPTION_ID" {
  type    = string
  default = ""
}

variable "ARM_CLIENT_ID" {
  type    = string
  default = ""
}

variable "ARM_TENANT_ID" {
  type    = string
  default = ""
}

variable "ARM_CLIENT_SECRET" {
  type    = string
  default = ""
}

variable "rg_name" {
  type = string
}

variable "rp_vm_name" {
  type    = string
  default = "rp-vm-01"
}

variable "region_vms" {
  type    = string
  default = "westeurope"
}

variable "rp_ani_id" {
  type = string
}

variable "asa_rp_vm_name" {
  type        = string
  description = "Can contain only lowercase letter & numbers, no special signs"
  default     = "diagrpvm01"
}

variable "rp_vm_os_disk_name" {
  type    = string
  default = "rp-vm-os-disk"
}

variable "rp_vm_computer_name" {
  type    = string
  default = "rp-vm-01"
}

variable "rp_vm_adm_user" {
  type      = string
  default   = "rp-admin"
  sensitive = true
}

variable "asa_web01_vm_name" {
  type        = string
  description = "Can contain only lowercase letter & numbers, no special signs"
  default     = "diagwebvm01"
}

variable "web01_vm_name" {
  type    = string
  default = "web-server-vm-01"
}

variable "web01_ani_id" {
  type = string
}

variable "web01_vm_os_disk_name" {
  type    = string
  default = "weba-vm-os-disk"
}

variable "web01_vm_computer_name" {
  type    = string
  default = "web-server-vm-01"
}

variable "web01_vm_adm_user" {
  type      = string
  default   = "web-admin"
  sensitive = true
}

variable "asa_web02_vm_name" {
  type        = string
  description = "Can contain only lowercase letter & numbers, no special signs"
  default     = "diagwebvm02"
}

variable "web02_vm_name" {
  type    = string
  default = "web-server-vm-02"
}

variable "web02_ani_id" {
  type = string
}

variable "web02_vm_os_disk_name" {
  type    = string
  default = "webb-vm-os-disk"
}

variable "web02_vm_computer_name" {
  type    = string
  default = "web-server-vm-02"
}

variable "web02_vm_adm_user" {
  type      = string
  default   = "web-admin"
  sensitive = true
}



