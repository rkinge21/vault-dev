#!/bin/sh
set -o xtrace
export VAULT_ADDR=http://127.0.0.1:8200
export VAULT_TOKEN=root

#call the tidy API to clen up revoked certs
vault write pki_int/tidy \
   safety_buffer=5s \
    tidy_cert_store=true \
    tidy_revocation_list=true
