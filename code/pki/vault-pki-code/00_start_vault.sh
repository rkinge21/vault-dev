#!!! ---------------------------------------------  DEV Mode ---------------------------------------------!!!
cd /e/Tutorials/Vault/VaultWork/dev/

#Create 2 directories :
#	mkdir vault-data
#	mkdir logs
	
cd /e/Tutorials/Vault/VaultWork/dev/
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root
export LOG_FILE='/e/Tutorials/Vault/VaultWork/dev/logs/vault.log'
nohup vault server -dev -dev-root-token-id root > $LOG_FILE 2>&1 &

sleep 5
cat logs/vault.log


vault operator unseal 


# Cross-Chek :
	 curl -k -s --head $VAULT_ADDR/v1/sys/health
	 curl -s -H "X-Vault-Token: $VAULT_TOKEN" --request GET  $VAULT_ADDR/v1/sys/host-info | jq -r .
#	 or
	 http://127.0.0.1:8200/ui/
#	 or 
	 vault status

# Kill Process :
	ps -ef | grep vault
	kill -9 692


cd /e/Tutorials/Vault/VaultWork/code/pki/vault-pki-code
rm -rf certs/
mkdir -p certs/pki_root
mkdir -p certs/pki_int
