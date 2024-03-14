# User Authentication With Keycloak

TODO: Intro

## Setup

* Install `gum` by following the instructions in https://github.com/charmbracelet/gum#installation.
* Watch https://youtu.be/U8zCHA-9VLA if you are not familiar with Charm Gum.

```bash
chmod +x manuscript/user-authentication/keycloak.sh

./manuscript/user-authentication/keycloak.sh
```

## Do

* Keycloak does not work with `nip.io`. A "real" domain with SSL certificates is required. To circumbent that, we'll open it through `port-forward`.

```sh
kubectl port-forward svc/keycloak 8080:8080 -n keycloak
```

* Open [http://localhost:8080](http://localhost:8080) from the output in a browser.
* Select `Administration Console` and `Sign In` using `admin` as both username and password.
* Explore the dashboard

## Continue The Adventure

* [Access Control](../access/README.md)
