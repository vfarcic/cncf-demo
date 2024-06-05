# Managing Secrets In Kubernetes With Markhor

Markhor is a lightweight Kubernetes operator that lets you manage Kubernetes Secret using SOPS. The developers can create encrypted manifests -MarhorSecrets- which are automatically decrypted and applied once they reach the cluster.

More details at https://github.com/markhork8s/markhor

## Setup

Run this script on a machine with access to the Kubernetes cluster to install Markhor.
Take note of the public key printed at the end.

In this demo, we use [age](https://github.com/FiloSottile/age) as the encryption method but the tool also supports others, like AWS KMS, GCP KMS and Azure Key Vault (see https://github.com/markhork8s/markhor/blob/main/docs/methods.md).

```bash
#!/usr/bin/env bash

set -e

echo "---- Checking that the required programs are installed ----"
checkCommands() {
  local commands=("kubectl" "openssl" "git" "awk" "sed" "mktemp" "pwd" "age-keygen" "base64" "cat" "tr" "sleep" "rm")

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

echo "---- Checking that the K8s cluster is reachable ----"
kubectl get namespaces >/dev/null

echo "---- Creating temporary directory ----"
CURRENT_DIR=$(pwd)
TMPDEMODIR=$(mktemp -d)
cd $TMPDEMODIR

echo "---- Cloning the markhor repository ----"
git clone --depth 1 https://github.com/markhork8s/markhor/ .

echo "---- Generating a public and private key ----"
KEY_PAIR=$(age-keygen 2>/dev/null)

PUBLIC_KEY=$(echo "$KEY_PAIR" | awk '/public key:/{print $NF}')
PRIVATE_KEY=$(echo "$KEY_PAIR" | awk 'NR==3{print}')

echo "Public Key: $PUBLIC_KEY"
echo "Private Key: ${PRIVATE_KEY:0:20}...${PRIVATE_KEY: -4}"
unset KEY_PAIR

echo "---- Adding the private key in the manifest ----"
cd ./manifests
sed -i "s/age_keys.txt: .*/age_keys.txt: $PRIVATE_KEY/" private_key_secret.yaml

#Check that the private key was set correctly (else the script will exit thanks to set -e)
grep $PRIVATE_KEY private_key_secret.yaml >/dev/null

unset PRIVATE_KEY

echo "---- Generating TLS secret for admission webhook ----"
echo 'y' | ./gen_hook_tls_secret.sh

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
