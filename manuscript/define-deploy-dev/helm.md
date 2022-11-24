# Define And Deploy The App To Dev With Helm

TODO: Intro

## Setup

* [Install the `helm` CLI](https://helm.sh/docs/intro/install)

```bash
yq --inplace ".ingress.host = \"dev.cncf-demo.$DOMAIN\"" \
    helm/app/values.yaml

yq --inplace ".image.repository = \"$IMAGE\"" \
    helm/app/values.yaml
```

## Do

```bash
ls -1 helm/app/templates

cat helm/app/templates/deployment.yaml

cat helm/app/templates/service.yaml

cat helm/app/templates/ingress.yaml

cat helm/app/values.yaml

yq --inplace ".image.tag = \"v0.0.1\"" helm/app/values.yaml

helm upgrade --install cncf-demo helm/app --namespace dev --wait

echo "http://dev.cncf-demo.$DOMAIN"

# Open it in a browser
```

## Undo The Changes

Execute the commands that follow **ONLY** if you want to change your mind and go back.

```bash
helm delete cncf-demo --namespace dev

yq --inplace ".image.tag = \"latest\"" helm/app/values.yaml
```

## Continue The Adventure

[Use HTTPS](../https/story.md)