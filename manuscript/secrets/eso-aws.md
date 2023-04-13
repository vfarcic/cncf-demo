# Managing Secrets From AWS With External Secrets Operator (ESO)

TODO: Intro

## Setup

```bash
aws secretsmanager create-secret --name production-postgresql \
    --region us-east-1 \
    --secret-string '{"password": "YouWillNeverFindOut"}'

kubectl --namespace external-secrets \
    create secret generic aws \
    --from-literal access-key-id=$AWS_ACCESS_KEY_ID \
    --from-literal secret-access-key=$AWS_SECRET_ACCESS_KEY

cp eso/secret-store-aws.yaml infra/.

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
