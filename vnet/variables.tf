variable "vpc_name" {
  type    = string
  default = "rp-vpc"
}

variable "region_vnet" {
  type    = string
  default = "westeurope"
}

variable "address_space_vnet" {
  type    = string
  default = "172.0.0.0/24"
}

variable "rg_name" {
  type = string
}

variable "ARM_SUBSCRIPTION_ID" {
  type    = string
  default = ""
}

variable "ARM_TENANT_ID" {
  type    = string
  default = ""
}

variable "ARM_CLIENT_ID" {
  type    = string
  default = ""
}

variable "ARM_CLIENT_SECRET" {
  type    = string
  default = ""
}

variable "pb_sub_name" {
  type    = string
  default = "pb-sub"
}

variable "pb_sub_cidr" {
  type    = string
  default = "172.0.0.0/25"
}

variable "pv_sub_name" {
  type    = string
  default = "pv-sub"
}

variable "pv_sub_cidr" {
  type    = string
  default = "172.0.0.128/25"
}

variable "rp_vm_ip_name" {
  type    = string
  default = "rp-vm-public-ip"
}

variable "rp_vm_pb_ip_allocation" {
  type    = string
  default = "Static"
}

variable "nat_ip_name" {
  type    = string
  default = "nat-ip-name"
}

variable "nat_pb_ip_allocation" {
  type    = string
  default = "Static"
}

variable "nat_pb_ip_sku" {
  type    = string
  default = "Standard"
}

variable "nat_ip_prefix_name" {
  type    = string
  default = "nat-ip-prefix"
}

variable "nat_ip_prefix_length" {
  type    = number
  default = 30
}

variable "rp_ani_name" {
  type    = string
  default = "rp-vm-ani-01"
}

variable "rp_ani_ipconf" {
  type    = string
  default = "rp-ani-ipconf"
}

variable "rp_vm_pv_ip_allocation" {
  type    = string
  default = "Dynamic"
}

variable "web_vm_01_ani_name" {
  type    = string
  default = "web-vm-ani-01"
}

variable "web_vm_02_ani_name" {
  type    = string
  default = "web-vm-ani-02"
}

variable "web_vm_pv_ip_allocation" {
  type    = string
  default = "Static"
}

variable "web_vm_01_pv_ip" {
  type    = string
  default = "172.0.0.140"
}

variable "web_vm_02_pv_ip" {
  type    = string
  default = "172.0.0.145"
}

variable "web_vm_ani_ipconf" {
  type    = string
  default = "web-vm-ani-ipconf"
}

variable "pb_sub_sg_name" {
  type    = string
  default = "pb-sub-sg"
}

variable "pv_sub_sg_name" {
  type    = string
  default = "pv-sub-sg"
}

variable "nat_gw_name" {
  type    = string
  default = "nat-gw-01"
}

variable "nat_gw_sku" {
  type    = string
  default = "Standard"
}

variable "nat_gw_timeout" {
  type    = number
  default = 10
}


