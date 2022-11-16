# Source: TODO:

#########
# TODO: #
# TODO: #
#########

# Additional Info:
# - TODO:

#########
# Intro #
#########

# Projects:
# - Graduated & incubating: https://www.cncf.io/projects/
# - Sandox: https://www.cncf.io/sandbox-projects

# It's a stateful app with PostgreSQL database.

# TODO: Intro

# TODO: Title screen

#########
# Setup #
#########

# TODO: Convert to a script

git clone https://github.com/vfarcic/cncf-demo

cd cncf-demo

# Create a GKE cluster.
# If using a different cluster, some commands or manifests might need to be adjusted.

helm repo add traefik \
    https://helm.traefik.io/traefik

helm repo update

helm upgrade --install \
    traefik traefik/traefik \
    --namespace traefik \
    --create-namespace \
    --wait

export INGRESS_HOST=$(kubectl \
    --namespace traefik \
    get svc traefik \
    --output jsonpath="{.status.loadBalancer.ingress[0].ip}")

echo $INGRESS_HOST

# TODO: Change to Harbor registry
export REGISTRY=docker.io/vfarcic

# Install `yq` CLI from https://github.com/mikefarah/yq

yq --inplace \
    ".ingress.host = \"cncf-demo.$INGRESS_HOST.nip.io\"" \
    helm/values.yaml

yq --inplace \
    ".spec.rules[0].host = \"cncf-demo.$INGRESS_HOST.nip.io\"" \
    kustomize/base/ingress.yaml

yq --inplace \
    ".image.repository = \"$REGISTRY/cncf-demo\"" \
    helm/values.yaml

yq --inplace \
    ".image.tag = \"latest\"" \
    helm/values.yaml

yq --inplace \
    ".spec.template.spec.containers[0].image = \"$REGISTRY/cncf-demo:latest\"" \
    kustomize/base/deployment.yaml

kubectl create namespace dev

kubectl create namespace production

# Make sure that Docker is running

#######################################
# Store Container Image To A Registry #
#######################################

# - [-] Docker Hub

# - [ ] Harbor

# TODO:

# - [-] AWS Elastic Container Registry (ECR)

#########################
# Build Container Image #
#########################

# - [-] Docker

# - [-] Kaniko

# - [X] Buildpacks

pack build $REGISTRY/cncf-demo:v0.0.1

docker image ls

docker image push $REGISTRY/cncf-demo:v0.0.1

####################################
# Define And Deploy The App To Dev #
####################################

# - [X] Helm

ls -1 helm/templates

cat helm/values.yaml

yq --inplace \
    ".image.tag = \"v0.0.1\"" \
    helm/values.yaml

helm upgrade --install cncf-demo helm \
    --namespace dev \
    --wait

curl "http://cncf-demo.$INGRESS_HOST.nip.io"

# - [X] Kustomize (part of `kubectl`)

cd kustomize/base

ls -1

kustomize edit set image \
    $REGISTRY/cncf-demo=$REGISTRY/cncf-demo:v0.0.1

cd ../../

kubectl --namespace dev apply --kustomize kustomize/base

# - [ ] CDK For Kubernetes (cdk8s)

# TODO:

# - [ ] Carvel

# TODO:

# - [ ] Knative

# TODO:

# - [ ] KubeVela

# TODO:

# - [ ] Crossplane

# TODO:

# TODO: Continue

# Platform
# - [ ] Kubernetes
# - [ ] Crossplane
# - [ ] KEDA
# - [ ] KubeVirt
# - [ ] k3s
# Networking:
# - [ ] LinkerD
# - [ ] Dapr
# - [ ] Istio
# Policies, security:
# - [ ] Open Policy Agent (OPA)
# - [ ] CertManager
# - [ ] Falco
# - [ ] Kyverno
# App management:
# - [ ] Argo Rollout
# - [ ] Crossplane
# - [ ] SchemaHero
# Pipelines:
# - [ ] Argo Workflows
# - [ ] Keptn
# Deployment:
# - [ ] Argo CD
# - [ ] Flux
# - [ ] Argo Workflows
# Monitoring, Logging, and tracing:
# - [ ] FluentD (logging)
# - [ ] Jaeger (tracing)
# - [ ] Prometheus (monitoring)
# Other
containerd
CoreDNS
Envoy
etcd
Rook
Spiffe
Spire
The Update Framework (TUF)
TiKV
Vitess
Backstage
Chaos Mesh
Cilium
Cloud Custodian
CloudEvents
Container Network Interface (CNI)
Contour
Cortex
CRI-O
CubeFS
Emissary Ingress
Falco
gRPC
in-toto
KubeEdge
Litmus
Longhorn
NATS
Notary
OpenMetrics
OpenTelemetry
OperatorFramework
Thanos
Volcano
Aeraki Mesh
Akri
Antrea
Artifact Hub
Athenz
BFE
Chaosblade
Clusterpedia
CNI-Genie
Confidential Containers
ContainerSSH
Curiefense
Curve
Devfile
DevStream
Dex
Distribution
external-secrets
Fluid
Fonio
Hexa
Inclavare Containers
k8gb
K8up
Karmada
Keylime
Konveyor
Krator
Krustlet
Kube-OVN
kube-rs
KubeArmor
KubeDL
Kuberhealthy
Kubewarden
KUDO
Kuma
Kured
Lima
Meshery
Metal3-io
Network Service Mesh
Nocalhost
Open Cluster Management
Open Service Mesh
OpenGitOps
OpenKruise
OpenYurt
ORAS
Parsec
Piraeus Datastore
Pixie
Porter
Pravega
sealer
Serverless Devs
Serverless Workflow
Service Mesh Interface (SMI)
Service Mesh Performance
Skooner
Strimzi
Submariner
SuperEdge
Telepresence
Teller
Tinkerbell
Tremor
Trickster
Vineyard
Virtual Kubelet
wasmCloud
WasmEdge Runtime

# TODO: Gist

# TODO: Commands

#######################
# TODO: Pros And Cons #
#######################

# Cons:
# - TODO:

# Pros:
# - TODO:

###########
# Destroy #
###########

# Helm

helm delete cncf-demo --namespace dev

# Kustomize

kubectl --namespace dev delete --kustomize kustomize/base
