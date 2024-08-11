resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

resource "azurerm_key_vault" "kv" {
  name                       = var.key_vault_name
  location                   = azurerm_resource_group.rg.location
  resource_group_name        = azurerm_resource_group.rg.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = var.sku_name
  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled

  tags = var.tags

  network_acls {
    default_action             = var.default_action_network_acls
    bypass                     = var.bypass_network_acls
    ip_rules                   = var.ip_rules_network_acls
    virtual_network_subnet_ids = var.virtual_network_subnet_ids_network_acls
  }
}

resource "azurerm_key_vault_access_policy" "access_policy" {
  key_vault_id = azurerm_key_vault.kv.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions         = var.key_permissions
  secret_permissions      = var.secret_permissions
  certificate_permissions = var.certificate_permissions
}

resource "azurerm_key_vault_key" "generated_key" {
  count = var.create_key ? 1 : 0

  name            = var.key_name
  key_vault_id    = azurerm_key_vault.kv.id
  key_type        = var.key_type
  key_size        = var.key_size
  key_opts        = var.key_opts
  expiration_date = var.key_expiration_date

  rotation_policy {
    automatic {
      time_before_expiry = var.time_before_expiry # "P30D"
    }

    expire_after         = var.expire_after         #"P90D"
    notify_before_expiry = var.notify_before_expiry #"P29D"
  }

  depends_on = [azurerm_key_vault_access_policy.access_policy]
}
