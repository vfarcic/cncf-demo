# Policies with Kyverno

TODO: Intro

## Setup

> Watch [Nix for Everyone: Unleash Devbox for Simplified Development](https://youtu.be/WiFLtcBvGMU) if you are not familiar with Devbox. Alternatively, you can skip Devbox and install all the tools listed in `devbox.json` yourself.

> Skip executing `devbox shell` if you are already inside the Shell from one of the previous episodes.

```bash
devbox shell

source .env
```

> Watch [The Future of Shells with Nushell! Shell + Data + Programming Language](https://youtu.be/zoX_S6d-XU4) if you are not familiar with Nushell. Alternatively, you can inspect the `dot.nu` script and transform the instructions in it to Bash or ZShell if you prefer not to use that Nushell script.

```sh
./dot.nu setup idp_argo_workflows $GITHUB_USER $GITHUB_TOKEN
```

## Do

```sh
cat workflows/argo.yaml

kubectl --namespace argo port-forward service/argo-server 2746:2746
```

> Open https://localhost:2746 in a browser

```sh
argo submit --namespace argo workflows/argo.yaml \
    --parameter registry-user=$GITHUB_USER --watch

argo list --namespace argo

argo get --namespace argo @latest

argo logs --namespace argo @latest
```

```sh
echo "https://github.com/users/$GITHUB_USER/packages/container/package/argo-workflows-demo-2"
```

> Open the URL from the output of the previous command in a browser.

> Clicks the `Package settings` button from the right-hand menu and `Change visibility` to `Public`.

```sh
git pull

cat app/deployment.yaml
```

> Click the `+ SUBMIT NEW WORKFLOW` button in the Argo Workflows Web UI.

NOTE: Don't to that. Create it using Argo CD and make it react to events.

FIXME: Change to NodePort

```sh
kubectl -n argo-events port-forward $(kubectl -n argo-events get pod -l eventsource-name=webhook -o name) 12000:12000
```

FIXME: https://argoproj.github.io/argo-events/eventsources/setup/github/

FIXME: Remove the whole code block

```sh
curl -d '{"message":"this is my first webhook"}' -H "Content-Type: application/json" -X POST http://localhost:12000/example

curl -d '{"message":"this is my first webhook"}' -H "Content-Type: application/json" -X POST http://webhook-eventsource.104.196.43.59.nip.io/example

kubectl -n argo-events get workflows | grep "webhook"
```

```sh
cat sensor.yaml

kubectl --namespace argo-events apply --filename sensor.yaml

cat event-source.yaml

echo "
apiVersion: v1
kind: Secret
metadata:
  name: github-access
type: Opaque
data:
  token: $(echo $GITHUB_TOKEN | base64)
" | kubectl --namespace argo-events apply --filename -

kubectl --namespace argo-events apply --filename event-source.yaml
```

FIXME: Trigger on push to the mainline or creation of a PR.

FIXME: https://argoproj.github.io/argo-events/sensors/triggers/argo-workflow/

FIXME: Trigger another workflow when the new release is up-and-running after being synced with Argo CD (https://kyverno.io/docs/writing-policies/external-data-sources/#variables-from-service-calls).

FIXME: Deploy Workflow with Argo CD

FIXME: Ephemeral environments (create and destroy on PR)

## Continue The Adventure

<!-- * [State Synchronization (GitOps)](../gitops-idp/README.md) -->
The adventure will continue soon.