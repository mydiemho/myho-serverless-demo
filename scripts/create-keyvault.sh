#!/bin/bash

# script to create keyvault
#!/bin/bash

set -e

PREFIX=$(whoami)
RESOURCE_GROUP="${PREFIX}-serverless-keyvault-test-rg"
KEYVAULT="${PREFIX}-serverless-test-kv"
REGION="westus"

SUBSCRIPTION=$(az account show | jq .name)
echo "You're using subscription: ${SUBSCRIPTION}"

echo "-----> Creating resource group"
az group create \
  -n ${RESOURCE_GROUP} \
  -l ${REGION} \
  -o table

echo 
echo "-----> Creating Keyvault"
az keyvault create \
  -n ${KEYVAULT} \
  -g ${RESOURCE_GROUP} \
  -l ${REGION} \
  -o table
