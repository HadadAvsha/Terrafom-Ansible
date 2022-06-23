<!-- BEGIN_TF_DOCS -->
This is a Virtual Machine Scale Set Module 
Using the root to define missing variables and info

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_linux_virtual_machine_scale_set.VMSS](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine_scale_set) | resource |
| [azurerm_monitor_autoscale_setting.scaling](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_autoscale_setting) | resource |
| [azurerm_virtual_machine_scale_set_extension.script](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_scale_set_extension) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_BEpool_id"></a> [BEpool\_id](#input\_BEpool\_id) | n/a | `any` | n/a | yes |
| <a name="input_LB_natpool_id"></a> [LB\_natpool\_id](#input\_LB\_natpool\_id) | n/a | `any` | n/a | yes |
| <a name="input_RSG_name"></a> [RSG\_name](#input\_RSG\_name) | n/a | `any` | n/a | yes |
| <a name="input_VMSS_nsg_id"></a> [VMSS\_nsg\_id](#input\_VMSS\_nsg\_id) | n/a | `any` | n/a | yes |
| <a name="input_VMSS_size"></a> [VMSS\_size](#input\_VMSS\_size) | n/a | `any` | n/a | yes |
| <a name="input_VMSS_subnet_id"></a> [VMSS\_subnet\_id](#input\_VMSS\_subnet\_id) | n/a | `any` | n/a | yes |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | n/a | `any` | n/a | yes |
| <a name="input_admin_user"></a> [admin\_user](#input\_admin\_user) | n/a | `any` | n/a | yes |
| <a name="input_application_port"></a> [application\_port](#input\_application\_port) | Port that you want to expose to the external load balancer | `number` | `8080` | no |
| <a name="input_location"></a> [location](#input\_location) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_admin_password"></a> [admin\_password](#output\_admin\_password) | outputs the admin password to root in order to output to user at completion |
<!-- END_TF_DOCS -->