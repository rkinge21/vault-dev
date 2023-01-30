storage "file" {
  path    = "/e/Tutorials/Vault/VaultWork/enterprise/vault-data"
  node_id = "node1"
}

listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = "true"
  // tls_cert_file = "/path/to/fullchain.pem"
  // tls_key_file  = "/path/to/privkey.pem"
}

ui            = true
api_addr 	    = "http://127.0.0.1:8200"
disable_mlock = true
log_level 	  = "TRACE"
cluster_addr 	= "http://127.0.0.1:8201"