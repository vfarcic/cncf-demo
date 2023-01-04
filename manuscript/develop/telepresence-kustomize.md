# Develop With Telepresence And Kustomize

TODO: Intro

## Do

```bash
go run .

cat ping.go

# In a separate terminal
curl "http://localhost:8080/ping?url=http://cncf-demo:8080"

# `ctrl+c`

kubectl --namespace dev get services

telepresence connect

telepresence list --namespace dev

telepresence intercept cncf-demo --namespace dev \
     --port 8080:http --env-file silly-demo.env

cat silly-demo.env

curl "http://cncf-demo:8080"

go run .

# In a separate terminal
curl "http://localhost:8080/ping?url=http://cncf-demo:8080"

# `ctrl+c`

telepresence leave cncf-demo-dev
```

## Continue The Adventure

[Create And Manage Production Kubernetes Cluster](../cluster/story.md)
