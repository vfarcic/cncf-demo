echo "[default]
aws_access_key_id = $AWS_ACCESS_KEY_ID
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
" >aws-creds.conf

kubectl --namespace crossplane-system \
    create secret generic aws-creds \
    --from-file creds=./aws-creds.conf

kubectl wait --for=condition=healthy provider.pkg.crossplane.io \
    --all --timeout=300s

kubectl apply \
    --filename crossplane-config/provider-config-aws-official.yaml

yq --inplace ".crossplane.destination = \"aws\"" settings.yaml
