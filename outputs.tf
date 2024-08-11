output "key_vault_access_policy_id" {
  description = "The ID of the key vault access policy."
  value       = azurerm_key_vault_access_policy.access_policy.id
}

output "key_vault_resource_id" {
  description = "The ID of the key vault."
  value       = azurerm_key_vault.kv.id
}

output "key_id" {
  description = "The ID of the key vault key."
  value       = try(azurerm_key_vault_key.generated_key[0].id, null)
}
