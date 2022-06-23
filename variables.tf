variable "name_prefix" {
  description = "prefix name"
  default     = "TF-postgres"
}

variable "location" {
  description = "Loaction of objects in azure"
  default     = "East US"
  type        = string
  #options = ["North Central US", "East US"]
}

variable "RSG_name" {
  description = "Name of Resource group"
  type        = string
  default     = "production"
  #options = ["staging", "production"]
}

variable "size" {
  description = "VM size"
  type        = string
  default     = "Standard_B2ms"
  #options = ["Standard_B2s", "Standard_B2ms"]
}

variable "DB_name_prefix" {
  description = "Prefix for postgres server name"
  default = "DataBase"
}


#variable for network range
variable "node_address_space" {
  description = "address space of vnet"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

#variable for app subnet range
variable "node_address_prefix" {
  description = "subnet address of app VMs"
  type        = list(string)
  default     = ["10.0.0.0/24"]
}

variable "application_port" {
  description = "Port that you want to expose to the external load balancer"
  default     = 8080
}

#variable for db subnet range
variable "db_address_prefix" {
  description = "subnet of postgres"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "myip" {
  description = "enter your ip in order to obtain SSH capabilities"
  default     = "109.186.152.248"
}

variable "Environment" {
  description = "Deployed in Environment"
  type        = string
  default     = "Staging"
  #options = ["Staging", "Production"]
}


