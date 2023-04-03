# Setup PostgreSQL DB In Google Cloud With Crossplane

TODO: Intro

## Setup

```bash
export XP_PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

export XP_DESTINATION=google

chmod +x manuscript/db/crossplane-google.sh

./manuscript/db/crossplane-google.sh

# GKE starts with a very small control plane.
# Since a lot of CRDs were installed, GKE is likely going to
#   detect that its control plane is too small for it and
#   increase its size automatically.
# That process might take a while and the control plane might
#   be inaccessible for a while.
# You might want to wait for a while (e.g., an hour) for the
#   new control plane to be full operational.
```

## How Did You Define Your App?

* [Helm](crossplane-helm.md)
* [Kustomize](crossplane-kustomize.md)
* [Carvel ytt](crossplane-carvel.md)
* [cdk8s](crossplane-cdk8s.md)