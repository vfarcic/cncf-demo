# Managing Secrets With External Secrets Operator (ESO)

TODO: Intro

## Setup

```bash
export GITOPS_APP=$(yq ".gitOps.app" settings.yaml)

cp $GITOPS_APP/external-secrets.yaml infra/.

git add . 

git commit -m "External Secrets"

git push
```

## Which Cloud Provider Did You Choose?

* [Google Cloud](eso-google.md)
* [AWS](eso-aws.md)
* [Azure](eso-azure.md)
