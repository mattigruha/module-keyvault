variable "resource_group_name" {
  description = "Name of the resource group that is created to deploy the resources in."
  type        = string
}

variable "location" {
  description = "The location where the resource group is located."
  default     = "West Europe"
  type        = string
}

variable "key_vault_name" {
  description = "Name of the key vault"
  type        = string
}

variable "sku_name" {
  description = "The name of the SKU used for the key vault."
  type        = string
}

variable "soft_delete_retention_days" {
  description = "Amount of days for the soft delete retention period. It can be between 7 and 90 (inclusive) days or 0 which sets the retention period to indefinite."
  type        = number
  default     = 7
}

variable "purge_protection_enabled" {
  description = "Whether or not to enable purge protection for the key vault."
  type        = bool
  default     = true
}

variable "create_key" {
  description = "Whether or not to create a key in the key vault."
  type        = bool
  default     = false

}
variable "key_name" {
  description = "The name of the key created in the key vault."
  type        = string
  default     = null
}

variable "key_type" {
  description = "The type of the key created in the key vault. Possible values are EC (Elliptic Curve), EC-HSM, RSA and RSA-HSM."
  type        = string
  default     = "RSA"
}

variable "key_size" {
  description = "The size of the key created in the key vault. Possible values are: 2048, 3072, 4096. This field is required if key_type is RSA or RSA-HSM."
  type        = string
  default     = null
}

variable "key_opts" {
  description = "They key options for the key created in the key vault. Possible values are: decrypt, encrypt, sign, unwrapKey, verify and wrapKey."
  type        = list(string)
  default     = null
}

variable "tags" {
  description = "Tags used for the resources."
  type        = map(string)
}

variable "default_action_network_acls" {
  description = "The default action for network ACLs. Possible values are: Allow and Deny."
  type        = string
  default     = "Deny"
}

variable "bypass_network_acls" {
  description = "The bypass for network ACLs. Possible values are: AzureServices, None and Logging."
  type        = string
  default     = "AzureServices"
}

variable "ip_rules_network_acls" {
  description = "List of IP addresses or CIDR blocks that can access the Key Vault"
  type        = list(string)
  default     = null
}

variable "virtual_network_subnet_ids_network_acls" {
  description = "List of subnet IDs that can access the Key Vault"
  type        = list(string)
  default     = null
}

variable "key_permissions" {
  description = "The permissions to keys in the vault. Possible values are: GetRotationPolicy, Purge, Encrypt, Decrypt, UnwrapKey, WrapKey, Verify, Sign, Get, List, Update, Create, Import, Delete, Recover, Backup, Restore, GetRotationPolicy, SetRotationPolicy, Rotate, Purge and Release."
  type        = list(string)
  default     = ["Get", "List", "Create", "Update", "Delete", "Recover", "GetRotationPolicy"]
}

variable "secret_permissions" {
  description = "The permissions to secrets in the vault. Possible values are: Backup, Delete, Get, List, Purge, Recover, Restore and Set"
  type        = list(string)
  default     = ["Get", "List", "Restore", "Set"]
}

variable "certificate_permissions" {
  description = "The permissions to certificates in the vault. Possible values are: Purge, Get, List, Update, Create, Import, Delete, Recover, Backup, Restore, ManageContacts, ManageIssuers, GetIssuers, ListIssuers, SetIssuers and DeleteIssuers ."
  type        = list(string)
  default     = ["Get", "List", "Update", "Create", "Import"]
}

variable "key_expiration_date" {
  description = "The expiration date for the key. This field is required if key_type is RSA or RSA-HSM."
  type        = string
  default     = null
}

variable "time_before_expiry" {
  description = "The time before the key expires. This field is required if key_type is RSA or RSA-HSM."
  type        = string
  default     = null
}

variable "expire_after" {
  description = "The time after which the key expires. This field is required if key_type is RSA or RSA-HSM."
  type        = string
  default     = null
}

variable "notify_before_expiry" {
  description = "The time before the key expires when the vault will send a notification email. This field is required if key_type is RSA or RSA-HSM."
  type        = string
  default     = null
}
