#!/bin/bash

set -e

## OPTIONAL: only if you're not using Serverless Framework to deploy the app

# script to allow function app access to keyvault


PREFIX=$(whoami)
RESOURCE_GROUP="${PREFIX}-serverless-keyvault-demo-rg"
KEYVAULT="${PREFIX}-serverless-demo-kv"
REGION="westus"

### NOTE: The function app and all dependent infrastructures have to be created first
APP_RESOURCE_GROUP=$1
if [[ -z $APP_RESOURCE_GROUP ]]; then
  echo "You didn't pass in a resource group.  Abort..."
  exit 1
fi

# this need to exist already
APP_NAME=$2
if [[ -z $APP_NAME ]]; then
  echo "You didn't pass in a function app name.  Abort..."
  exit 1
fi

echo "-----> Create system-assigned manage identity on function app"
az functionapp identity assign \
  -g ${APP_RESOURCE_GROUP} \
  -n ${APP_NAME} \
  -o table

echo
echo "-----> Retrieve principal id of function app"
PRINCIPAL_ID=$(az functionapp identity show -g ${APP_RESOURCE_GROUP} -n ${APP_NAME} --query principalId -o tsv)
echo ${PRINCIPAL_ID}

echo
echo "-----> Grant function app read access to keyvault"
az keyvault set-policy \
  -n ${KEYVAULT} \
  -g ${RESOURCE_GROUP} \
  --object-id ${PRINCIPAL_ID} \
  --secret-permissions get \
  -o table

echo
echo "-----> Verify that access policy for function app has been added"
az keyvault show \
  -n ${KEYVAULT} \
  -g ${RESOURCE_GROUP} \
  --query "properties.accessPolicies[?objectId=='${PRINCIPAL_ID}']" \
  -o table
