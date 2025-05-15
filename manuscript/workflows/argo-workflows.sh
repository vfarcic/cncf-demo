#!/bin/sh

cp workflows/* cncf-demo-app/.

if [ "$API" = "kubevela" ]; then
    mv cncf-demo-app/dot-kubevela.nu cncf-demo-app/dot.nu
fi

cd cncf-demo-app

git add .

git commit -m "CI"

git pull

git push

cd ..
