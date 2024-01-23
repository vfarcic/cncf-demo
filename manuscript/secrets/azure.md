# Managing Secrets From Azure With External Secrets Operator (ESO)

TODO: Intro

## Setup

```bash
TENANT_ID=$(az account show --query tenantId | tr -d \")

export RESOURCE_GROUP=$(\
    yq ".production.azure.resourceGroup" settings.yaml)

export KEYVAULT=cncf-demo-$(date +%Y%m%d%H%M%S)

yq --inplace ".production.azure.keyvault = \"$KEYVAULT\"" \
    settings.yaml

az keyvault create --name $KEYVAULT \
    --resource-group $RESOURCE_GROUP --location eastus \
    | tee azure-keyvault.json

az keyvault secret set --name production-postgresql \
    --vault-name $KEYVAULT \
    --value "{\"password\": \"YouWillNeverFindOut\"}"

export APP_ID=$(az ad app create \
    --display-name "CNCF Demo App" --query appId | tr -d \")

az ad sp create --id $APP_ID

az ad app permission add --id $APP_ID \
    --api-permissions f53da476-18e3-4152-8e01-aec403e6edc0=Scope \
    --api cfa8b339-82a2-471a-a3c9-0fc0be7a4093

az ad app permission grant --id $APP_ID \
    --api cfa8b339-82a2-471a-a3c9-0fc0be7a4093 \
    --scope Directory.Read.All

az ad app credential reset --id $APP_ID

# Replace `[...]` with the `password`
export CRED_PASS=[...]

az keyvault set-policy --name $KEYVAULT \
    --object-id $APP_ID --secret-permissions get

kubectl --namespace external-secrets \
    create secret generic azure-secret-sp \
    --from-literal=ClientID=$APP_ID \
    --from-literal=ClientSecret=$CRED_PASS

yq --inplace ".spec.provider.azurekv.tenantId = \"$TENANT_ID\"" \
    eso/secret-store-azure.yaml

yq --inplace \
    ".spec.provider.azurekv.vaultUrl = \"https://$KEYVAULT.vault.azure.net\"" \
    eso/secret-store-azure.yaml

cat eso/secret-store-azure.yaml

cp eso/secret-store-azure.yaml infra/.

git add .

git commit -m "Secret Store"

git push

kubectl get clustersecretstores

# Wait until the ClusterSecretStore appears
```

## How Did You Define Your App?

* [Helm](helm.md)
* [Kustomize](kustomize.md)
* [Carvel ytt](carvel.md)
* [cdk8s](cdk8s.md)
