#creating subnet for DB
resource "azurerm_subnet" "db_subnet" {
  name                 = "db-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = var.db_address_prefix
  service_endpoints    = ["Microsoft.Storage"]

  delegation {
    name = "fs"

    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"

      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

#creating NSG for DB
resource "azurerm_network_security_group" "db_nsg" {
  name                = "${var.name_prefix}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "5432in"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "5432"
    source_address_prefix      = "10.0.0.0/24"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "5432out"
    priority                   = 1000
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "10.0.0.0/24"
  }
#Implicit_deny all inbound traffic with lower priority
security_rule {
    name                       = "Implicit_deny"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

#assosiating NSG to DB subnet
resource "azurerm_subnet_network_security_group_association" "db_association" {
  subnet_id                 = azurerm_subnet.db_subnet.id
  network_security_group_id = azurerm_network_security_group.db_nsg.id

}

#creating dns zone in order to be able to find the DB server
resource "azurerm_private_dns_zone" "pri_dns" {
  name                = "${var.RSG_name}-pdz.postgres.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name

  depends_on = [azurerm_subnet_network_security_group_association.db_association]

}
#linking dns zone with the Vnet we created
resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  name                  = "${var.RSG_name}-pdzvnetlink.com"
  private_dns_zone_name = azurerm_private_dns_zone.pri_dns.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
  resource_group_name   = azurerm_resource_group.rg.name

}

#creates PostgreSQL Flexible Server
resource "azurerm_postgresql_flexible_server" "postgres_flex_server" {
  name                   = "${var.RSG_name}-avsha-postgres-server"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  version                = "13"
  delegated_subnet_id    = azurerm_subnet.db_subnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.pri_dns.id
  administrator_login    = var.db_admin_user
  administrator_password = var.db_admin_password
  storage_mb             = 32768
  sku_name               = "B_Standard_B1ms"
  backup_retention_days  = 7
#  require_secure_transport = false
  depends_on = [azurerm_private_dns_zone_virtual_network_link.link]

}

#diabling ssl for PostgreSQL Flexible Server
resource "azurerm_postgresql_flexible_server_configuration" "postgres_configuration" {
  name      = "require_secure_transport"
  server_id = azurerm_postgresql_flexible_server.postgres_flex_server.id
  value     = "off"

}
#creates Database in PostgreSQL Flexible Server
resource "azurerm_postgresql_flexible_server_database" "postgres" {
  name      = "avshapostgres"
  server_id = azurerm_postgresql_flexible_server.postgres_flex_server.id
  collation = "en_US.UTF8"
  charset   = "UTF8"

}