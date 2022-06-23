
![ansible](https://user-images.githubusercontent.com/106066816/175376549-c2b4d3ef-0a98-4e6c-b9b1-c39c3a1f078a.png) ![terraform](https://user-images.githubusercontent.com/106066816/175376565-1b39ff13-3fa8-406a-9aac-d32bebd82494.png)
![ansibleonazure01](https://user-images.githubusercontent.com/106066816/175378683-f46b9997-fbf5-41a5-9c47-8694ed480eb7.png).<br/>
This week we needed to use Terraform (Iaac) to build the infrastructure and then use Ansible to configure our application.<br/>
This is My project result and i hope youll use and enjoy.<br/>
To begin create a filename.tf file in the root directory with the following variables and assign desired values.<br/>

variable "admin_user" {<br/>
  description = "User name to use as the admin account on the VMs that will be part of the VM scale set"<br/>
  default     = ""<br/>
}<br/>
variable "admin_password" {<br/>
  description = "Default password for admin account"<br/>
  default     = ""<br/>
}<br/>
variable "db_admin_user" {<br/>
  description = "User name for postgres"<br/>
  default     = ""<br/>
}<br/>
variable "db_admin_password" {<br/>
  description = "Default password for postgres admin account"<br/>
  default     = ""<br/>
}<br/>
Next<br/>
enter your ip in the "myip" variable in variables.tf file<br/>
variable "myip" {<br/>
  description = "enter your ip in order to obtain SSH capabilities"<br/>
  default     = ""<br/>
}<br/>
In preferred terrafrom terminal run:<br/>
'terraform init'<br/>
'terraform plan'<br/>
'terraform apply' -> 'yes'<br/>
Enjoy!

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.10.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.10.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.3.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_VMSS"></a> [VMSS](#module\_VMSS) | ./VMSS | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_lb.LB](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/lb) | resource |
| [azurerm_lb_backend_address_pool.bepool](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/lb_backend_address_pool) | resource |
| [azurerm_lb_nat_pool.lbnatpool](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/lb_nat_pool) | resource |
| [azurerm_lb_outbound_rule.LB_out](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/lb_outbound_rule) | resource |
| [azurerm_lb_probe.LB_probe](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/lb_probe) | resource |
| [azurerm_lb_probe.LB_probe_80](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/lb_probe) | resource |
| [azurerm_lb_rule.lbnatrule](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/lb_rule) | resource |
| [azurerm_network_security_group.VMSS_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.db_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/network_security_group) | resource |
| [azurerm_postgresql_flexible_server.postgres_flex_server](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/postgresql_flexible_server) | resource |
| [azurerm_postgresql_flexible_server_configuration.postgres_configuration](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/postgresql_flexible_server_configuration) | resource |
| [azurerm_postgresql_flexible_server_database.postgres](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/postgresql_flexible_server_database) | resource |
| [azurerm_private_dns_zone.pri_dns](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/private_dns_zone) | resource |
| [azurerm_private_dns_zone_virtual_network_link.link](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/private_dns_zone_virtual_network_link) | resource |
| [azurerm_public_ip.pub_ip](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/public_ip) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/resource_group) | resource |
| [azurerm_subnet.db_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/subnet) | resource |
| [azurerm_subnet.vmss-subnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.VMSS_association](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.db_association](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/3.10.0/docs/resources/virtual_network) | resource |
| [random_string.fqdn](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default                              | Required |
|------|-------------|------|--------------------------------------|:--------:|
| <a name="input_DB_name_prefix"></a> [DB\_name\_prefix](#input\_DB\_name\_prefix) | Prefix for postgres server name | `string` | `"DataBase"`                         | no |
| <a name="input_Environment"></a> [Environment](#input\_Environment) | Deployed in Environment | `string` | `"Staging"`                          | no |
| <a name="input_RSG_name"></a> [RSG\_name](#input\_RSG\_name) | Name of Resource group | `string` | `"production"`                       | no |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Default password for admin account | `string` | `"VMSS admin poassword"`             | no |
| <a name="input_admin_user"></a> [admin\_user](#input\_admin\_user) | User name to use as the admin account on the VMs that will be part of the VM scale set | `string` | `"VMSS admin user name"`             | no |
| <a name="input_application_port"></a> [application\_port](#input\_application\_port) | Port that you want to expose to the external load balancer | `number` | `8080`                               | no |
| <a name="input_db_address_prefix"></a> [db\_address\_prefix](#input\_db\_address\_prefix) | subnet of postgres | `list(string)` | <pre>[<br>  "10.0.1.0/24"<br>]</pre> | no |
| <a name="input_db_admin_password"></a> [db\_admin\_password](#input\_db\_admin\_password) | Default password for postgres admin account | `string` | `"password of DB administrator"`     | no |
| <a name="input_db_admin_user"></a> [db\_admin\_user](#input\_db\_admin\_user) | User name for postgres | `string` | `"postgres admin user name"`         | no |
| <a name="input_location"></a> [location](#input\_location) | Loaction of objects in azure | `string` | `"East US"`                          | no |
| <a name="input_myip"></a> [myip](#input\_myip) | enter your ip in order to obtain SSH capabilities | `string` | `"your.ip.ssh.access"`               | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | prefix name | `string` | `"TF-postgres"`                      | no |
| <a name="input_node_address_prefix"></a> [node\_address\_prefix](#input\_node\_address\_prefix) | subnet address of app VMs | `list(string)` | <pre>[<br>  "10.0.0.0/24"<br>]</pre> | no |
| <a name="input_node_address_space"></a> [node\_address\_space](#input\_node\_address\_space) | address space of vnet | `list(string)` | <pre>[<br>  "10.0.0.0/16"<br>]</pre> | no |
| <a name="input_size"></a> [size](#input\_size) | VM size | `string` | `"Standard_B2ms"`                    | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_DB_admin_password"></a> [DB\_admin\_password](#output\_DB\_admin\_password) | n/a |
| <a name="output_DB_username"></a> [DB\_username](#output\_DB\_username) | n/a |
| <a name="output_LB_public_ip"></a> [LB\_public\_ip](#output\_LB\_public\_ip) | n/a |
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | n/a |
| <a name="output_azurerm_postgresql_flexible_server"></a> [azurerm\_postgresql\_flexible\_server](#output\_azurerm\_postgresql\_flexible\_server) | n/a |
| <a name="output_postgresql_flexible_server_database_name"></a> [postgresql\_flexible\_server\_database\_name](#output\_postgresql\_flexible\_server\_database\_name) | n/a |
<!-- END_TF_DOCS -->
