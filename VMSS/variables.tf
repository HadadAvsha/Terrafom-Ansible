variable "RSG_name" {}
variable "location" {}
variable "application_port" {
  description = "Port that you want to expose to the external load balancer"
  default     = 8080
}
variable "admin_user" {}
variable "admin_password" {}
variable "VMSS_nsg_id" {}
variable "VMSS_subnet_id" {}
variable "BEpool_id" {}
variable "LB_natpool_id" {}
variable "VMSS_size" {}
