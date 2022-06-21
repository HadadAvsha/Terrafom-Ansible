variable "RSG_name" {}
#azurerm_resource_group.rg.name
variable "location" {}
#azurerm_resource_group.rg.location
#variable "vnet_name" {}
#azurerm_virtual_network.vnet.name
variable "application_port" {
  description = "Port that you want to expose to the external load balancer"
  default     = 8080
}
variable "admin_user" {}
variable "admin_password" {}
variable "VMSS_nsg_id" {}
#[azurerm_network_security_group.VMSS_nsg]
variable "VMSS_subnet_id" {}
#azurerm_subnet.vmss-subnet.id
variable "BEpool_id" {}
#[azurerm_lb_backend_address_pool.bepool.id]
variable "LB_natpool_id" {}
#[azurerm_lb_nat_pool.lbnatpool.id]
variable "VMSS_size" {}
#variable "tags" {}
#variable "Environment" {}