resource "azurerm_public_ip" "pub_ip" {
  name                = "vmss-public-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  domain_name_label   = random_string.fqdn.result
  sku                 = "Standard"

}

resource "azurerm_lb" "LB" {
  name                = "vmss-lb"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.pub_ip.id
  }


}
resource "azurerm_lb_backend_address_pool" "bepool" {
  loadbalancer_id = azurerm_lb.LB.id
  name            = "BackEndAddressPool"

}




resource "azurerm_lb_probe" "LB_probe" {
  #  resource_group_name = azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.LB.id
  name                = "8080Probe"
  protocol            = "Tcp"
  port                = 8080
  interval_in_seconds = 5

}

resource "azurerm_lb_probe" "LB_probe_80" {
  #  resource_group_name = azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.LB.id
  name                = "80Probe"
  protocol            = "Tcp"
  port                = 80
  interval_in_seconds = 5

}

resource "azurerm_lb_rule" "lbnatrule" {
  #  resource_group_name            = azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.LB.id
  name                           = "8080"
  protocol                       = "Tcp"
  frontend_port                  = var.application_port
  backend_port                   = var.application_port
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.bepool.id]
  frontend_ip_configuration_name = "PublicIPAddress"
  probe_id                       = azurerm_lb_probe.LB_probe.id
  disable_outbound_snat          = true

}


resource "azurerm_lb_nat_pool" "lbnatpool" {
  resource_group_name            = azurerm_resource_group.rg.name
  name                           = "ssh"
  loadbalancer_id                = azurerm_lb.LB.id
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50100
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"

}


resource "azurerm_lb_outbound_rule" "LB_out" {
  loadbalancer_id         = azurerm_lb.LB.id
  name                    = "out"
  protocol                = "All"
  backend_address_pool_id = azurerm_lb_backend_address_pool.bepool.id


  frontend_ip_configuration {
    name = "PublicIPAddress"
  }
}

