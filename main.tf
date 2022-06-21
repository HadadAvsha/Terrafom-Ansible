#change RSG name
#size


#create random string for unique and random usage
module "VMSS" {
  source         = "./VMSS"
  RSG_name       = var.RSG_name
  location       = var.location
  VMSS_size      = var.size
  VMSS_nsg_id    = azurerm_network_security_group.VMSS_nsg.id
  VMSS_subnet_id = azurerm_subnet.vmss-subnet.id
  BEpool_id      = azurerm_lb_backend_address_pool.bepool.id
  LB_natpool_id  = azurerm_lb_nat_pool.lbnatpool.id
  admin_user     = var.admin_user
  admin_password = var.admin_password

  #  Environment = var.Environment
}

resource "random_string" "fqdn" {
  length  = 6
  special = false
  upper   = false
  number  = false
}


# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.RSG_name
  location = var.location
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  address_space       = var.node_address_space
}



#creating subnet for VMSS (app)

resource "azurerm_subnet" "vmss-subnet" {
  name                 = "vmss-subnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.node_address_prefix

}

#creating NSG for VMSS(app) wan and lan

resource "azurerm_network_security_group" "VMSS_nsg" {
  name                = "app-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "8080"
    priority                   = 200
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "8080"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                         = "22in"
    priority                     = 100
    direction                    = "Inbound"
    access                       = "Allow"
    protocol                     = "Tcp"
    source_port_range            = "*"
    destination_port_range       = "22"
    source_address_prefix        = var.myip
    destination_address_prefixes = var.node_address_prefix
  }



}

#assosiating NSG to VMSS(app) subnet

resource "azurerm_subnet_network_security_group_association" "VMSS_association" {
  subnet_id                 = azurerm_subnet.vmss-subnet.id
  network_security_group_id = azurerm_network_security_group.VMSS_nsg.id

}

