##################################################################
# Vault Provider  details
// export VAULT_ADDR=http://127.0.0.1:8200
// export VAULT_TOKEN=root
##################################################################

terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = ">= 2.19.0"
    }
  }
}

provider "vault" {
  address = var.vault_address
  token   = var.vault_token
}

##################################################################
#                 Generate Certs
# Ref : https://www.tfwriter.com/vault/r/vault_pki_secret_backend_cert.html
# Ref : https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/pki_secret_backend_cert
##################################################################

resource "vault_pki_secret_backend_cert" "app" {
  backend     = var.vault_intermediate_ca_name
  name        = var.vault_role_name
  common_name = var.vault_cname
  alt_names   = ["ironman.mcu.com", "captain.mcu.com"]
  ttl         = "1m"
}


##################################################################
#         Save Certs locally inside certs/
##################################################################

resource "local_file" "private_key" {
  content  = vault_pki_secret_backend_cert.app.private_key
  filename = "certs/avengers.mcu.com.key"
}

resource "local_file" "certificate" {
  content  = vault_pki_secret_backend_cert.app.certificate
  filename = "certs/avengers.mcu.com.crt"
}

resource "local_file" "issuing_ca" {
  content  = vault_pki_secret_backend_cert.app.issuing_ca
  filename = "certs/issuing_ca_avengers.mcu.com.crt"
}

resource "local_file" "ca_chain" {
  content  = vault_pki_secret_backend_cert.app.ca_chain
  filename = "certs/ca_chain.crt"
}