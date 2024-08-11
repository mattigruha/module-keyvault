# Module to create an Azure Key Vault, Access Policy and Key (optional)

## Changelog
Initial setup

## Requirements

| Name | Version |
|------|---------|
| [terraform](#requirement\_terraform) | >= 1.0.0 |
| [azurerm](#requirement\_azurerm) | >= 3.0.0, < 4.0.0 |

## Providers

| Name | Version |
|------|---------|
| [azurerm](#provider\_azurerm) | 3.84.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.access_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_key.generated_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| [bypass\_network\_acls](#input\_bypass\_network\_acls) | The bypass for network ACLs. Possible values are: AzureServices, None and Logging. | `string` | `"AzureServices"` | no |
| [certificate\_permissions](#input\_certificate\_permissions) | The permissions to certificates in the vault. Possible values are: Purge, Get, List, Update, Create, Import, Delete, Recover, Backup, Restore, ManageContacts, ManageIssuers, GetIssuers, ListIssuers, SetIssuers and DeleteIssuers . | `list(string)` | ```[ "Get", "List", "Update", "Create", "Import" ]``` | no |
| [create\_key](#input\_create\_key) | Whether or not to create a key in the key vault. | `bool` | `false` | no |
| [default\_action\_network\_acls](#input\_default\_action\_network\_acls) | The default action for network ACLs. Possible values are: Allow and Deny. | `string` | `"Deny"` | no |
| [expire\_after](#input\_expire\_after) | The time after which the key expires. This field is required if key\_type is RSA or RSA-HSM. | `string` | `null` | no |
| [ip\_rules\_network\_acls](#input\_ip\_rules\_network\_acls) | List of IP addresses or CIDR blocks that can access the Key Vault | `list(string)` | `null` | no |
| [key\_expiration\_date](#input\_key\_expiration\_date) | The expiration date for the key. This field is required if key\_type is RSA or RSA-HSM. | `string` | `null` | no |
| [key\_name](#input\_key\_name) | The name of the key created in the key vault. | `string` | `null` | no |
| [key\_opts](#input\_key\_opts) | They key options for the key created in the key vault. Possible values are: decrypt, encrypt, sign, unwrapKey, verify and wrapKey. | `list(string)` | `null` | no |
| [key\_permissions](#input\_key\_permissions) | The permissions to keys in the vault. Possible values are: GetRotationPolicy, Purge, Encrypt, Decrypt, UnwrapKey, WrapKey, Verify, Sign, Get, List, Update, Create, Import, Delete, Recover, Backup, Restore, GetRotationPolicy, SetRotationPolicy, Rotate, Purge and Release. | `list(string)` | ```[ "Get", "List", "Create", "Update", "Delete", "Recover", "GetRotationPolicy" ]``` | no |
| [key\_size](#input\_key\_size) | The size of the key created in the key vault. Possible values are: 2048, 3072, 4096. This field is required if key\_type is RSA or RSA-HSM. | `string` | `null` | no |
| [key\_type](#input\_key\_type) | The type of the key created in the key vault. Possible values are EC (Elliptic Curve), EC-HSM, RSA and RSA-HSM. | `string` | `"RSA"` | no |
| [key\_vault\_name](#input\_key\_vault\_name) | Name of the key vault | `string` | n/a | yes |
| [location](#input\_location) | The location where the resource group is located. | `string` | `"West Europe"` | no |
| [notify\_before\_expiry](#input\_notify\_before\_expiry) | The time before the key expires when the vault will send a notification email. This field is required if key\_type is RSA or RSA-HSM. | `string` | `null` | no |
| [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | Whether or not to enable purge protection for the key vault. | `bool` | `true` | no |
| [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group that is created to deploy the resources in. | `string` | n/a | yes |
| [secret\_permissions](#input\_secret\_permissions) | The permissions to secrets in the vault. Possible values are: Backup, Delete, Get, List, Purge, Recover, Restore and Set | `list(string)` | ```[ "Get", "List", "Restore", "Set" ]``` | no |
| [sku\_name](#input\_sku\_name) | The name of the SKU used for the key vault. | `string` | n/a | yes |
| [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | Amount of days for the soft delete retention period. It can be between 7 and 90 (inclusive) days or 0 which sets the retention period to indefinite. | `number` | `7` | no |
| [tags](#input\_tags) | Tags used for the resources. | `map(string)` | n/a | yes |
| [time\_before\_expiry](#input\_time\_before\_expiry) | The time before the key expires. This field is required if key\_type is RSA or RSA-HSM. | `string` | `null` | no |
| [virtual\_network\_subnet\_ids\_network\_acls](#input\_virtual\_network\_subnet\_ids\_network\_acls) | List of subnet IDs that can access the Key Vault | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| [key\_id](#output\_key\_id) | The ID of the key vault key. |
| [key\_vault\_access\_policy\_id](#output\_key\_vault\_access\_policy\_id) | The ID of the key vault access policy. |
| [key\_vault\_resource\_id](#output\_key\_vault\_resource\_id) | The ID of the key vault. |


## Usage
```hcl
variable "environment" {
  description = "The environment to deploy in."
  type        = string
  default     = "minimal"
}

module "customer_managed_key" {
  source = "../.."

  # Resource group configuration
  resource_group_name = "rg-customer-managed-key-test"
  location            = "West Europe"

  tags = {
    Project     = "modules/azure/customer-managed-key"
    Application = "Terraform Customer Managed Key"
    Environment = var.environment
    CreatedBy   = "Digital Survival Company"
    CreatedFor  = "Digital Survival Company"
  }

  # Key vault input variables
  key_vault_name             = "kv-module-test"
  sku_name                   = "standard"
  soft_delete_retention_days = "7"
  purge_protection_enabled   = true

  # Network ACL configuration
  default_action_network_acls = "Deny"
  bypass_network_acls         = "AzureServices"
  ip_rules_network_acls       = concat(local.dsc_runner_nat_public_cidrs)
  # var.virtual_network_subnet_ids_network_acls = Add subnet id here

  # Key vault access policy configuration
  key_permissions         = ["Purge", "Get", "List", "Create", "Update", "Delete", "Recover", "GetRotationPolicy"]
  secret_permissions      = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
  certificate_permissions = ["Purge", "Get", "List", "Update", "Create", "Import", "Delete"]

  # Key input variables
  create_key = false # Set to true if you want to create a generated key
  # key_name   = "key-customer-managed-key-test"
  # key_type   = "RSA"
  # key_size   = "2048"
  # key_opts   = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  # key_expiration_date  = "2024-12-12T23:59:59Z" # Expiration UTC datetime (Y-m-d'T'H:M:S'Z').
  # time_before_expiry   = "P30D"
  # expire_after         = "P90D"
  # notify_before_expiry = "P29D"
}
