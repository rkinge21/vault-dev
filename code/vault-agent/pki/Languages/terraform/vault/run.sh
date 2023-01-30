#!/bin/bash

rm -rf certs/

echo -e "\n-------     terraform init     -------- \n"
terraform init

echo -e "\n-------     terraform plan     -------- \n"
terraform plan -state=terraform.tfstate -var-file=vault.tfvars

echo -e "\n-------     terraform apply     -------- \n"
terraform apply -auto-approve -state=terraform.tfstate -var-file=vault.tfvars
# terraform apply -auto-approve -state=terraform.tfstate -var-file=vault.tfvars > certs/terraform_output.txt

echo -e "\n-------     terraform output     -------- \n"
terraform output > certs/terraform_output.txt

echo -e "\n-------     create certs/ca_chain_avengers.mcu.com.pem    -------- \n"
echo -e '\n\n' >> certs/avengers.mcu.com.crt
cat certs/avengers.mcu.com.crt certs/issuing_ca_avengers.mcu.com.crt >> certs/ca_chain_avengers.mcu.com.pem

echo -e "\n---------     Done     ---------- \n"