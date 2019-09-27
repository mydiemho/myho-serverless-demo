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

## Not expected

If the reference is not resolved, that means keyvault access is not working

```
"Shhhhh.. it's a secret: @Microsoft.KeyVault(SecretUri=https://myho-serverless-test-kv.vault.azure.net/secrets/MySuperSecretName/5ebad1a426a347de9d6200219369dcc4)"
```

## Grant app access

There's a script `scripts/grant-app-access.sh` that add the function app to the keyvault's access policy. Can you verify that you can now
see the secrets after doing this outside of serverless?
