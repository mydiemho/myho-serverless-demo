# Azure Functions

Refer to [Serverless docs](https://serverless.com/framework/docs/providers/azure/guide/intro/) for more information.

## Keyvault integration testing

1. Create keyvault

```bash
 ./scripts/create-keyvault.sh
```

1. Add secrets

```bash
./scripts/add-secrets.sh
```

1. Update yaml with keyvault info

```yaml
keyvault:
  name: <KEYVAULT NAME>
  resourceGroup: <KEYVAULT RESOURCE GROUP>
```

1. Update yaml with new secret uri

```yaml
SUPER_SECRET: "@Microsoft.KeyVault(SecretUri=<CHANGE_ME>)"
```

1. Deploy & test

```bash
sls invoke -f secrets
```

### Not expected

If the reference is not resolved, that means keyvault access is not working

```
"Shhhhh.. it's a secret: @Microsoft.KeyVault(SecretUri=https://myho-serverless-test-kv.vault.azure.net/secrets/MySuperSecretName/5ebad1a426a347de9d6200219369dcc4)"
```

### Grant app access

There's a script `scripts/grant-app-access.sh` that add the function app to the keyvault's access policy. Can you verify that you can now
see the secrets after doing this outside of serverless?

## Testing

Waited 2 minutes after deploy, and still have no access

```
17:05:19 in myho-serverless-demo on  saveKeyVaultSyntax [!] is 📦 v1.0.0 via ⬢ v10.14.1 at ☸️  team12-aks took 1m 3s
➜ sls invoke -f secrets
Serverless: Logging into Azure
Serverless: Using subscription ID: d36d0808-a967-4f73-9fdc-32ea232fc81d
Serverless: URL for invocation: http://myho-wus-dev-serverless-test.azurewebsites.net/api/secrets
Serverless: Invoking function secrets with GET request
Serverless: "Shhhhh.. it's a secret: @Microsoft.KeyVault(SecretUri=https://myho-serverless-test2-kv.vault.azure.net/secrets/MySuperSecretName/8efeb50e879d433594fffb51d15fdc1a)"

17:05:47 in myho-serverless-demo on  saveKeyVaultSyntax [!] is 📦 v1.0.0 via ⬢ v10.14.1 at ☸️  team12-aks took 23s
➜ sls invoke -f secrets
Serverless: Logging into Azure
Serverless: Using subscription ID: d36d0808-a967-4f73-9fdc-32ea232fc81d
Serverless: URL for invocation: http://myho-wus-dev-serverless-test.azurewebsites.net/api/secrets
Serverless: Invoking function secrets with GET request
Serverless: "Shhhhh.. it's a secret: @Microsoft.KeyVault(SecretUri=https://myho-serverless-test2-kv.vault.azure.net/secrets/MySuperSecretName/8efeb50e879d433594fffb51d15fdc1a)"

17:05:56 in myho-serverless-demo on  saveKeyVaultSyntax [!] is 📦 v1.0.0 via ⬢ v10.14.1 at ☸️  team12-aks took 6s
➜ sls invoke -f secrets
Serverless: Logging into Azure
Serverless: Using subscription ID: d36d0808-a967-4f73-9fdc-32ea232fc81d
Serverless: URL for invocation: http://myho-wus-dev-serverless-test.azurewebsites.net/api/secrets
Serverless: Invoking function secrets with GET request
Serverless: "Shhhhh.. it's a secret: @Microsoft.KeyVault(SecretUri=https://myho-serverless-test2-kv.vault.azure.net/secrets/MySuperSecretName/8efeb50e879d433594fffb51d15fdc1a)"

17:06:05 in myho-serverless-demo on  saveKeyVaultSyntax [!] is 📦 v1.0.0 via ⬢ v10.14.1 at ☸️  team12-aks took 6s
➜ sls invoke -f secrets
Serverless: Logging into Azure
Serverless: Using subscription ID: d36d0808-a967-4f73-9fdc-32ea232fc81d
Serverless: URL for invocation: http://myho-wus-dev-serverless-test.azurewebsites.net/api/secrets
Serverless: Invoking function secrets with GET request
Serverless: "Shhhhh.. it's a secret: @Microsoft.KeyVault(SecretUri=https://myho-serverless-test2-kv.vault.azure.net/secrets/MySuperSecretName/8efeb50e879d433594fffb51d15fdc1a)"

17:07:10 in myho-serverless-demo on  saveKeyVaultSyntax [!] is 📦 v1.0.0 via ⬢ v10.14.1 at ☸️  team12-aks took 5s
➜ sls invoke -f secrets
Serverless: Logging into Azure
Serverless: Using subscription ID: d36d0808-a967-4f73-9fdc-32ea232fc81d
Serverless: URL for invocation: http://myho-wus-dev-serverless-test.azurewebsites.net/api/secrets
Serverless: Invoking function secrets with GET request
Serverless: "Shhhhh.. it's a secret: @Microsoft.KeyVault(SecretUri=https://myho-serverless-test2-kv.vault.azure.net/secrets/MySuperSecretName/8efeb50e879d433594fffb51d15fdc1a)"

17:07:21 in myho-serverless-demo on  saveKeyVaultSyntax [!] is 📦 v1.0.0 via ⬢ v10.14.1 at ☸️  team12-aks took 6s
➜ sls invoke -f secrets
Serverless: Logging into Azure
Serverless: Using subscription ID: d36d0808-a967-4f73-9fdc-32ea232fc81d
Serverless: URL for invocation: http://myho-wus-dev-serverless-test.azurewebsites.net/api/secrets
Serverless: Invoking function secrets with GET request
Serverless: "Shhhhh.. it's a secret: @Microsoft.KeyVault(SecretUri=https://myho-serverless-test2-kv.vault.azure.net/secrets/MySuperSecretName/8efeb50e879d433594fffb51d15fdc1a)"
```
