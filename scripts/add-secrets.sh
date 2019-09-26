#!/bin/bash

# script to add secrets to keyvault
#!/bin/bash

set -e

PREFIX=$(whoami)
RESOURCE_GROUP="${PREFIX}-serverless-keyvault-demo-rg"
KEYVAULT="${PREFIX}-serverless-demo-kv"
REGION="westus"

SECRET_NAME=${1:-"MySuperSecretName"}
SECRET_VALUE=${2:-"ItIsASecret"}

echo "-----> Create secret ${SECRET_NAME}"
az keyvault secret set \
  --vault-name ${KEYVAULT}  \
  --name ${SECRET_NAME} \
  --value ${SECRET_VALUE} \
  -o table

echo
echo "------> Retrieve secret url for ${SECRET_NAME}"
SECRET_ID=$(az keyvault secret show -n ${SECRET_NAME} --vault-name ${KEYVAULT} --query "id" -o tsv)
echo "Secret id: - ${SECRET_ID}"
echo "Secret url: @Microsoft.KeyVault(SecretUri=${SECRET_ID})"

echo
echo "-----> View value of secret ${SECRET_NAME}"
az keyvault secret show \
  --vault-name ${KEYVAULT} \
  --name ${SECRET_NAME} \
  -o table
