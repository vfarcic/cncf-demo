#! /usr/bin/env bash

NS=markhor
SECRET_NAME=markhor-tls-secret
SERVICE_NAME=markhor
KEY_BITS=2048
CERT_DURATION_SECONDS=2147483646

echo "This script generates a new TLS key for the admission webhook and gets the cluster's CA to sign it."
echo
echo "Check that these are correct. Press 'y' to conferm or anything else to cancel"
echo "    Target namespace: $NS"
echo "    Target secret name: $SECRET_NAME"
echo "    Target service name: $SERVICE_NAME"
echo "    RSA key length (in bits): $KEY_BITS"
echo "    Certificate duration (in seconds): $CERT_DURATION_SECONDS"

read -n 1 A
if [ "$A" != "y" ]; then
  echo "Operation cancelled"
  exit 0
fi
echo

set -e

checkCommandPresent() {
  command -v "$1" >/dev/null || {
    echo "Missing required command: $1"
    exit 1
  }
}

checkCommandPresent openssl
checkCommandPresent kubectl
checkCommandPresent mktemp
checkCommandPresent base64
checkCommandPresent cat
checkCommandPresent tr
checkCommandPresent sleep
checkCommandPresent rm

SERVICE_NAME_COMPLETE=$SERVICE_NAME.$NS.svc
CSR_NAME=$SERVICE_NAME-csr
TMPDIR=$(mktemp -d)

# Create a private key and CSR for the webhook
if [ $(cat /proc/sys/kernel/random/entropy_avail) -lt 256 ]; then
  echo "Not enough entropy"
  exit 1
fi
openssl genrsa -out $TMPDIR/$SERVICE_NAME.key $KEY_BITS
CONF=$TMPDIR/csr.conf
cat <<EOF >> $CONF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
prompt = no
[req_distinguished_name]
CN = $SERVICE_NAME_COMPLETE
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth, serverAuth
subjectAltName = @alt_names
[alt_names]
DNS.1 = $SERVICE_NAME.$NS
DNS.2 = $SERVICE_NAME_COMPLETE
EOF
openssl req -new -key $TMPDIR/$SERVICE_NAME.key \
  -out $TMPDIR/$SERVICE_NAME.csr \
  -subj "/CN=system:node:$SERVICE_NAME_COMPLETE /OU="system:nodes" /O=system:nodes" \
  -config $CONF

kubectl delete csr $CSR_NAME 2>/dev/null || true
kubectl create namespace $NS 2>/dev/null || true

# Create a CertificateSigningRequest for the webhook
cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: $CSR_NAME
spec:
  request: $(cat $TMPDIR/$SERVICE_NAME.csr | base64 | tr -d "\n")
  signerName: kubernetes.io/kubelet-serving
  expirationSeconds: $CERT_DURATION_SECONDS
  groups:
    - system:authenticated
  usages:
    - digital signature
    - key encipherment
    - server auth
EOF

# Approve the CertificateSigningRequest
kubectl certificate approve $CSR_NAME

# Retrieve the certificate from the CSR
# kubectl get csr $CSR_NAME -o jsonpath='{.status.certificate}' | base64 -d > $TMPDIR/$SERVICE_NAME.crt
while true; do
  kubectl get csr $CSR_NAME -o jsonpath='{.status.certificate}' | base64 -d > $TMPDIR/$SERVICE_NAME.crt
  if [ "$(cat $TMPDIR/$SERVICE_NAME.crt)" != "" ]; then
   break
  fi
  sleep 1
  echo "Waiting for the csr to be signed."
done

# Remove the CSR
kubectl delete csr $CSR_NAME

# Create a Kubernetes secret with the certificate and private key.
kubectl create secret tls $SECRET_NAME --cert=$TMPDIR/$SERVICE_NAME.crt --key=$TMPDIR/$SERVICE_NAME.key --namespace $NS

# Remove temporary files
rm -r $TMPDIR
