export SUBSCRIPTION_ID=$(az account show --query id -o tsv)

az ad sp create-for-rbac --sdk-auth --role Owner \
    --scopes /subscriptions/$SUBSCRIPTION_ID \
    | tee azure-creds.json

kubectl --namespace crossplane-system \
    create secret generic azure-creds \
    --from-file creds=./azure-creds.json

kubectl wait --for=condition=healthy provider.pkg.crossplane.io \
    --all --timeout=300s

kubectl apply \
    --filename crossplane-config/provider-config-azure-official.yaml
