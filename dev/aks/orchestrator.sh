#!/usr/bin/env bash

# read the access key from AZURE Secure Vault and set the environment variable so that it can be used later
# by terraform configuration files
export ARM_ACCESS_KEY=$(az keyvault secret show --name terraform-backend-key --vault-name tstorageacctKeyVault \
--query value -o tsv)

terraform init -backend-config="storage_account_name=tstorageacct03122018" \
-backend-config="container_name=terraform-state-container" \
-backend-config="key=aks.tfstate"

outfile=$(mktemp /tmp/output.XXXXXXXXXX)
terraform plan -out ${outfile}

terraform apply ${outfile}
