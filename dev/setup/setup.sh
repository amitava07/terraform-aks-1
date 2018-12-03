#!/usr/bin/env bash

RESOURCE_GROUP_NAME=terraform-state-rsg
STORAGE_ACCOUNT_NAME=tstorageacct03122018
CONTAINER_NAME=terraform-state-container
AZURE_LOCATION=southindia

STORAGE_ACCOUNT_KEY_VAULT=tstorageacctKeyVault
ACCESS_KEY_NAME=terraform-backend-key

# Create resource group
az group create --name ${RESOURCE_GROUP_NAME} --location ${AZURE_LOCATION}

# Create storage account (General Purpose V2)
az storage account create --resource-group ${RESOURCE_GROUP_NAME} \
--name ${STORAGE_ACCOUNT_NAME} --kind StorageV2 --sku Standard_LRS --encryption-services blob

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group ${RESOURCE_GROUP_NAME} \
--account-name ${STORAGE_ACCOUNT_NAME} --query [0].value -o tsv)

# Create blob container
az storage container create --name ${CONTAINER_NAME} --account-name ${STORAGE_ACCOUNT_NAME} \
--account-key ${ACCOUNT_KEY}

# Create key vault
az keyvault create --name ${STORAGE_ACCOUNT_KEY_VAULT} --resource-group ${RESOURCE_GROUP_NAME} \
--location ${AZURE_LOCATION}

# Add the secret
az keyvault secret set --vault-name ${STORAGE_ACCOUNT_KEY_VAULT} --name ${ACCESS_KEY_NAME} --value ${ACCOUNT_KEY}

# read the access key from AZURE Secure Vault and set the environment variable so that it can be used later
# by terraform configuration files
export ARM_ACCESS_KEY=$(az keyvault secret show --name ${ACCESS_KEY_NAME} --vault-name ${STORAGE_ACCOUNT_KEY_VAULT} \
--query value -o tsv)


echo "storage_account_name: $STORAGE_ACCOUNT_NAME"
echo "container_name: $CONTAINER_NAME"

