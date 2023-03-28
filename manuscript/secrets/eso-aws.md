# Managing Secrets From AWS With External Secrets Operator (ESO)

TODO: Intro

## Setup

```bash
aws secretsmanager create-secret --name production-postgresql \
    --secret-string '{"password": "YouWillNeverFindOut"}'

# TODO: Rewrite from Google to AWS

kubectl --namespace external-secrets \
    create secret generic google \
    --from-file=credentials=account.json

yq --inplace \
    ".spec.provider.gcpsm.projectID = \"$XP_PROJECT_ID\"" \
    eso/secret-store-google.yaml

cp eso/secret-store-google.yaml infra/.

git add .

git commit -m "Secret Store"

git push

kubectl --namespace external-secrets get clustersecretstores

# Wait until the ClusterSecretStore appears
```

## How Did You Define Your App?

* [Helm](helm.md)
* [Kustomize](kustomize.md)
* [Carvel ytt](carvel.md)
* [cdk8s](cdk8s.md)
