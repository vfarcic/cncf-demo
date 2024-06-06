# Managing Secrets In Kubernetes With Markhor

TODO: Intro

## Setup

* Install [age](https://github.com/FiloSottile/age)

```bash
# CURRENT_DIR=$(pwd)
# TMPDEMODIR=$(mktemp -d)
# cd $TMPDEMODIR

export KEY_PAIR=$(age-keygen)

export PUBLIC_KEY=$(echo "$KEY_PAIR" \
  | awk '/public key:/{print $NF}')

export PRIVATE_KEY=$(echo "$KEY_PAIR" | awk 'NR==3{print}')

cd ./manifests

yq --inplace ".stringData.\"age_keys.txt\" = \"$PRIVATE_KEY\"" \
    sops/secret.yaml

# FIXME: Continue rewriting

chmod +x sops/gen_hook_tls_secret.sh

echo 'y' | ./sops/gen_hook_tls_secret.sh

echo "---- Installing markhor ----"
./apply.sh

echo "---- Removing temporary files ----"
cd "$CURRENT_DIR"
rm -rf $TMPDEMODIR

echo "---- Showing the result ----"
echo -n "Waiting for the pod to become ready ."
while true; do
    pod_status=$(kubectl get pods -n markhor --no-headers=true | awk '{print $2}')

    if [[ $pod_status == "1/1" ]]; then
        echo
        break
    else
        echo -n "."
        sleep 10
    fi
done

kubectl get all -n markhor

echo "-----------"
echo "Remember that the public key is $PUBLIC_KEY"

```

## Usage

### Creating a Secret

Run this script to create an encrypted MarkhorSecret manifest (you will need the publc key generated during the setup).

```bash
#!/usr/bin/env bash

set -e

echo "---- Checking that the required programs are installed ----"
checkCommands() {
  local commands=("sops" "yq" "mktemp" "pwd" "rm")

  echo -n "These commands are required for this script: "
  printf "%s, " "${commands[@]}"
  printf "\b\b \n"

  for cmd in "${commands[@]}"; do
    command -v "$cmd" >/dev/null || {
      echo "Missing required command: $cmd"
      exit 1
    }
  done
}
checkCommands

echo "---- Creating temporary directory ----"
SECRET_FILE_NAME=postgresql-secret-aws.yaml

echo "---- Getting the public key ----"

read -p "Please input the public key and press enter: " PUBLIC_KEY
echo "Public key: $PUBLIC_KEY"

echo "---- Creating a sample Secret ----"

echo "---
apiVersion: v1
kind: Secret
metadata:
  name: cncf-demo-db-password
data:
  password: T1QrOXZQcDhMdXhoeFVQWVpLSk1kUG1YM04xTzBTd3YzWG5ZVjI0UFZzcz0=
" > "$SECRET_FILE_NAME"

echo "---- Converting the Secret to a MarkhorSecret ----"

wget --quiet https://raw.githubusercontent.com/markhork8s/markhor/main/utility_scripts/secret_to_markhorsecret.sh
chmod +x secret_to_markhorsecret.sh

./secret_to_markhorsecret.sh -i "$SECRET_FILE_NAME" -o "$SECRET_FILE_NAME"

echo "---- Encrypting ----"
sops --encrypt --age $PUBLIC_KEY --in-place --encrypted-regex '^(data|stringData)$' "$SECRET_FILE_NAME"

rm secret_to_markhorsecret.sh

echo "---- Apply to the cluster ----"

echo "Time to git commit, git push or kubectl apply $SECRET_FILE_NAME"

```

Now check that the secret was created with `kubectl get secret cncf-demo-db-password --output jsonpath="{.data.password}" | base64 --decode`

## Teardown

```bash
kubectl delete ns markhor
kubectl delete ValidatingWebhookConfiguration markhor-validation-webhook-config
kubectl delete ClusterRoleBinding markhor-role-binding
kubectl delete ClusterRole markhor-role
```
