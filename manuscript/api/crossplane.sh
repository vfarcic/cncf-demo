#!/bin/sh

echo "export API=crossplane" | tee -a .env

cd cncf-demo-app

cp ../crossplane/$HYPERSCALER-sql.yaml apps/silly-demo-db.yaml

cp ../crossplane/$HYPERSCALER-sql-password.yaml \
    apps/silly-demo-db-password.yaml

kubectl --namespace production apply \
    --filename apps/silly-demo-db-password.yaml

kubectl --namespace production apply \
    --filename apps/silly-demo-db.yaml

cp ../crossplane/app.yaml apps/silly-demo.yaml

kubectl --namespace production apply \
    --filename apps/silly-demo.yaml
