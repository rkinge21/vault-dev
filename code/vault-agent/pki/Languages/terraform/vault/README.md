# Mint a Certificate using Venafi-PKI via terraform

generate certificate using Venafi-PKI via terraform

## Usage

To run this, you need to execute:

```bash
$ terraform init
$ terraform plan -state=terraform.tfstate -var-file=venafi.tfvars
$ terraform apply -auto-approve -state=terraform.tfstate -var-file=venafi.tfvars
```
or

```bash
$ ./run.sh
```

Note that this example may create resources which can cost money. Run `terraform destroy -state=terraform.tfstate -var-file=venafi.tfvars` when you don't need these resources.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_venafi"></a> [aws](#requirement\_venafi) | >= 0.11.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_venafi"></a> [aws](#provider\_venafi) | >= 0.11.0 |

## Resources

| Name | Type |
|------|------|
| [venafi_certificate.app](https://registry.terraform.io/providers/Venafi/venafi/latest/docs/resources/venafi_certificate) | resource |


## Inputs

No inputs.

## Outputs

Inside certs/ folder, below file types will be created
1. app.crt          :   application signed certificate
2. app.key          :   application key
3. issuing_ca.crt   :   issuing ca certificate
4. ca_chain.pem     :   app.crt + issuing_ca.crt