output "private_key_type" {
  description = "returns a private_key_type"
  value       = vault_pki_secret_backend_cert.app.private_key_type
}

output "expiration" {
  description = "returns a expiration"
  value       = vault_pki_secret_backend_cert.app.expiration
}

output "id" {
  description = "returns an id"
  value       = vault_pki_secret_backend_cert.app.id
}
output "serial_number" {
  description = "returns a string"
  value       = vault_pki_secret_backend_cert.app.serial_number
}

// output "ca_chain" {
//   description = "returns a ca_chain"
//   value       = vault_pki_secret_backend_cert.app.ca_chain
// }

// output "certificate" {
//   description = "returns a server certificate"
//   value       = vault_pki_secret_backend_cert.app.certificate
// }

// output "issuing_ca" {
//   description = "returns an issuing_ca"
//   value       = vault_pki_secret_backend_cert.app.issuing_ca
// }

// output "private_key" {
//   description = "returns a server private_key"
//   value       = vault_pki_secret_backend_cert.app.private_key
//   sensitive   = true
// }

// output "app" {
//   value = vault_pki_secret_backend_cert.app
// }