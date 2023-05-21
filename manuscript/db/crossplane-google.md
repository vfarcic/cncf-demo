# Setup PostgreSQL DB In Google Cloud With Crossplane

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
export XP_PROJECT_ID=dot-$(date +%Y%m%d%H%M%S)

export XP_DESTINATION=google

chmod +x manuscript/db/crossplane-google.sh

./manuscript/db/crossplane-google.sh

# GKE starts with a very small control plane.
# Since a lot of CRDs were installed, GKE is likely going to
#   detect that its control plane is too small for it and
#   increase its size automatically.
# As a result, you might experience delays or errors like
#   `connection refused` or `TLS handshake timeout` (among
#   others).
# If that happens, wait for a while (e.g., 1h) for the control
#   plane nodes to be automatically changed for larger ones.
```

## How Did You Define Your App?

* [Helm](crossplane-helm.md)
* [Kustomize](crossplane-kustomize.md)
* [Carvel ytt](crossplane-carvel.md)
* [cdk8s](crossplane-cdk8s.md)