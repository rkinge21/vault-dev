#!/bin/sh
set -o xtrace
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root


#list all certificates created by the intermediate CA
vault list pki_int/certs
vault list pki_int/certs > cert_key_list