##################################################
#           Vault Provider details
##################################################

variable "vault_address" {
  type    = string
  default = "http://127.0.0.1:8200"
}

variable "vault_token" {
  type    = string
  default = "root"
}

##################################################
#           Vault  certificate details
##################################################
variable "vault_intermediate_ca_name" {
  type    = string
  default = "pki_int"
}
variable "vault_role_name" {
  type    = string
  default = "corporate-dot-demo-vault_cert"
}
variable "vault_cname" {
  type    = string
  default = "vault_cert.corporate.demo"
}
