#!/bin/sh

cd cncf-demo-app

cp ../kubevela/$HYPERSCALER-sql.yaml apps/silly-demo-db.yaml

cp ../kubevela/$HYPERSCALER-sql-password.yaml \
    apps/silly-demo-db-password.yaml

kubectl --namespace production apply \
    --filename apps/silly-demo-db-password.yaml

kubectl --namespace production apply \
    --filename apps/silly-demo-db.yaml

cp ../kubevela/app.yaml apps/silly-demo.yaml

kubectl --namespace production apply \
    --filename apps/silly-demo.yaml

