# Develop With Telepresence

TODO: Intro

## Setup

* Install and configure [Go](https://go.dev/doc/install)
* Install [`telepresence` CLI](https://www.getambassador.io/docs/telepresence/latest/install).

```bash
telepresence helm install
```

## Do

```bash
cat ping.go

go run .

# In a separate terminal
curl "http://localhost:8080/ping?url=http://cncf-demo:8080"

# `ctrl+c`

kubectl --namespace dev get services

telepresence connect

telepresence list --namespace dev

telepresence intercept cncf-demo --namespace dev \
     --port 8080:http --env-file silly-demo.env

curl "http://cncf-demo:8080"

go run .

# In a separate terminal
curl "http://localhost:8080/ping?url=http://cncf-demo:8080"

# `ctrl+c`

telepresence leave cncf-demo-dev

telepresence quit
```

## Continue The Adventure

* [Create and Manage a Production Kubernetes Cluster](../cluster/README.md)
