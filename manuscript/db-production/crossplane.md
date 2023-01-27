# Setup PostgreSQL DB In The Production Environment With Crossplane

TODO: Intro

## Setup

```bash
export XP_DESTINATION=$(\
    yq ".crossplane.destination" settings.yaml)

cat crossplane/create-secret-$XP_DESTINATION.sh

chmod +x crossplane/create-secret-$XP_DESTINATION.sh

./crossplane/create-secret-$XP_DESTINATION.sh
```

## How Did You Define Your App?

* [Helm](helm.md)
* [Kustomize](kustomize.md)
* [Carvel](carvel.md)
* [cdk8s](cdk8s.md)
