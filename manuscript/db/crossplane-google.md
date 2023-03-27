# Setup PostgreSQL DB In Google Cloud With Crossplane

TODO: Intro

## Setup

```bash
export XP_PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

export XP_DESTINATION=google

chmod +x manuscript/db/crossplane-google.sh

./manuscript/db/crossplane-google.sh
```

## How Did You Define Your App?

* [Helm](crossplane-helm.md)
* [Kustomize](crossplane-kustomize.md)
* [Carvel ytt](crossplane-carvel.md)
* [cdk8s](crossplane-cdk8s.md)