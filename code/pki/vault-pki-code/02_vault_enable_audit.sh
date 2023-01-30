#!/bin/sh
set -o xtrace

export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root

#login into Vault 
vault login root
#check the status of Vault server
vault status

#enable Audit and write logs to a file
vault audit enable file file_path=/e/Tutorials/Vault/VaultWork/dev/vault_audit.log

#enable another Audit and log to another file but with raw data
vault audit enable -path="file_raw" file  log_raw=true file_path=/e/Tutorials/Vault/VaultWork/dev/vault_audit_raw.log



	# Create Namespace and Enable Plugins:
	# 	vault namespace create 00-2bb029d1-cc2c-4042-8f59-14c016e98e5d
	# 	vault namespace create 01-d7444a96-13cf-4d00-a226-c9c4a2437533
	# 	vault namespace create 02-25f74a59-5545-4766-bf6f-40e38d59ba5c
	# 	clear
	# 	vault secrets enable -namespace=01-d7444a96-13cf-4d00-a226-c9c4a2437533 -path=venafi -plugin-name=venafi-pki-monitor plugin
	# 	vault secrets list -namespace=01-d7444a96-13cf-4d00-a226-c9c4a2437533
	# 	vault secrets disable -namespace=01-d7444a96-13cf-4d00-a226-c9c4a2437533 venafi

	# 	vault secrets list -namespace=01-d7444a96-13cf-4d00-a226-c9c4a2437533
	# 	vault secrets enable -namespace=01-d7444a96-13cf-4d00-a226-c9c4a2437533 -path=pki -plugin-name=venafi-pki-monitor plugin
	# 	vault secrets list -namespace=01-d7444a96-13cf-4d00-a226-c9c4a2437533

    # vault write pki/venafi/tpp     url="https://ec2amaz-4sbmf56.corporate.demo" trust_bundle_file="/apps/vault/base64Root.pem"     access_token="Gj4KmJaMk+X2QYUTgPwG8A=="
    # vault secrets list
    # vault secrets list -detailed
    # vault write pki/venafi-policy/default venafi_secret="tpp" zone="\\New\\VaultCACerts"

    # vault monitor -log-level=trace

