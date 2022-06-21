variable "name_prefix" {
  description = "prefix name"
  default     = "TF-postgres"
}

#location for creation

variable "RSG_name" {
  description = "Name of Resource group"
  type        = string
  default     = "Staging"
}
variable "location" {
  description = "Loaction of objects in azure"
  default     = "North Central US"
  type        = string
}

variable "DB_name_prefix" {
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
  description = "enter your ip"
  default     = "109.186.152.248"
}



variable "size" {
  description = "VM size"
  type        = string
  default     = "Standard_B2s"
  #options = ["Standard_B2s", "Standard_B2ms"]
}

variable "Environment" {
  description = "Deployed in Environment"
  type        = string
  default     = "Staging"
  #options = ["Staging", "Production"]
}


