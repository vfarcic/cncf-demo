# Setup PostgreSQL DB In AWS With Crossplane

TODO: Intro

## Setup

```bash
# Replace `[...]` with your access key ID`
export AWS_ACCESS_KEY_ID=[...]

# Replace `[...]` with your secret access key
export AWS_SECRET_ACCESS_KEY=[...]

echo "[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
" >aws-creds.conf

kubectl --namespace crossplane-system \
    create secret generic aws-creds \
    --from-file creds=./aws-creds.conf

kubectl apply --filename crossplane-config/provider-aws-official.yaml

kubectl get pkgrev

# Wait until all the packages are healthy

kubectl apply \
    --filename crossplane-config/provider-config-aws-official.yaml

export XP_DESTINATION=aws
```

## How Did You Define Your App?

* [Helm](crossplane-helm.md)
* [Kustomize](crossplane-kustomize.md)
* [Carvel](crossplane-carvel.md)