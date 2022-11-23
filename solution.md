## The Whole Story

```mermaid
flowchart TD;

    xxx--->setup

    setup(Setup);
    click setup "vfarcic/cncf-demo/blob/main/manuscript/setup.md"

    setup-->bci

    bci{{Build Container Image}}
    click bci "vfarcic/cncf-demo/blob/main/manuscript/build-container-image/story.md"
    style bci fill:blue
    bci1(Docker)
    click bci1 "vfarcic/cncf-demo/blob/main/manuscript/build-container-image/docker.md"
    bci2(Kaniko)
    click bci2 "vfarcic/cncf-demo/blob/main/manuscript/build-container-image/kaniko.md"
    bci3(Cloud Native Buildpacks / CNB)
    click bci3 "vfarcic/cncf-demo/blob/main/manuscript/build-container-image/buildpacks.md"

    bci-->bci1;
    bci-->bci2;
    bci-->bci3-->registry;

    registry{{Store Container Image In A Registry}}
    click registry "vfarcic/cncf-demo/blob/main/manuscript/registry/story.md"
    style registry fill:blue
    registry1(Docker Hub)
    click registry1 "vfarcic/cncf-demo/blob/main/manuscript/registry/docker-hub.md"
    registry2(Harbor)
    click registry2 "vfarcic/cncf-demo/blob/main/manuscript/registry/harbor.md"
    registry3(AWS Elastic Container Registry / ECR)
    click registry3 "vfarcic/cncf-demo/blob/main/manuscript/registry/ecr.md"

    registry-->registry1;
    registry-->registry2-->ddd;
    registry-->registry3;

    ddd{{Define And Deploy The App To Dev}}
    click ddd "vfarcic/cncf-demo/blob/main/manuscript/define-deploy-dev/story.md"
    style ddd fill:blue
    ddd1(Helm)
    click ddd1 "vfarcic/cncf-demo/blob/main/manuscript/define-deploy-dev/helm.md"
    ddd2(Kustomize)
    click ddd2 "vfarcic/cncf-demo/blob/main/manuscript/define-deploy-dev/kustomize.md"
    ddd3(Carvel)
    style ddd3 fill:red

    ddd-->ddd1-->https;
    ddd-->ddd2-->https;
    ddd-->ddd3-->https;

    https{{Use HTTPS}}
    click https "vfarcic/cncf-demo/blob/main/manuscript/https/story.md"
    style https fill:blue
    https1(HashiCorp Vault)
    click https1 "vfarcic/cncf-demo/blob/main/manuscript/https/vault.md"
    https2(Venafi)
    click https2 "vfarcic/cncf-demo/blob/main/manuscript/https/venafi.md"
    https3(cert-manager)
    click https3 "vfarcic/cncf-demo/blob/main/manuscript/https/cert-manager.md"
    https3-helm(Helm)
    click https3-helm "vfarcic/cncf-demo/blob/main/manuscript/https/cert-manager-helm.md"
    https3-kustomize(Kustomize)
    click https3-kustomize "vfarcic/cncf-demo/blob/main/manuscript/https/cert-manager-kustomize.md"
    https3-carvel(Carvel)
    style https3-carvel fill:red

    https-->https1;
    https-->https2;
    https-->https3;
    https3-->https3-helm;
    https3-->https3-kustomize;
    https3-->https3-carvel;
```

## TODO:

* Crossplane
* KEDA
* KubeVirt
* k3s
* LinkerD
* Dapr
* Istio
* Open Policy Agent (OPA)
* Falco
* Kyverno
* Argo Rollout
* Knative
* KubeVela
* Crossplane
* SchemaHero
* CDK For Kubernetes (cdk8s)
* Argo Workflows
* Keptn
* Argo CD
* Flux
* Argo Workflows
* FluentD (logging)
* Jaeger (tracing)
* Prometheus (monitoring)
* containerd
* CoreDNS
* Envoy
* etcd
* Rook
* Spiffe
* Spire
* The Update Framework (TUF)
* TiKV
* Vitess
* Backstage
* Chaos Mesh
* Cilium
* Cloud Custodian
* CloudEvents
* Container Network Interface (CNI)
* Contour
* Cortex
* CRI-O
* CubeFS
* Emissary Ingress
* Falco
* gRPC
* in-toto
* KubeEdge
* Litmus
* Longhorn
* NATS
* Notary
* OpenMetrics
* OpenTelemetry
* OperatorFramework
* Thanos
* Volcano
* Aeraki Mesh
* Akri
* Antrea
* Artifact Hub
* Athenz
* BFE
* Chaosblade
* Clusterpedia
* CNI-Genie
* Confidential Containers
* ContainerSSH
* Curiefense
* Curve
* Devfile
* DevStream
* Dex
* Distribution
* external-secrets
* Fluid
* Fonio
* Hexa
* Inclavare Containers
* k8gb
* K8up
* Karmada
* Keylime
* Konveyor
* Krator
* Krustlet
* Kube-OVN
* kube-rs
* KubeArmor
* KubeDL
* Kuberhealthy
* Kubewarden
* KUDO
* Kuma
* Kured
* Lima
* Meshery
* Metal3-io
* Network Service Mesh
* Nocalhost
* Open Cluster Management
* Open Service Mesh
* OpenGitOps
* OpenKruise
* OpenYurt
* ORAS
* Parsec
* Piraeus Datastore
* Pixie
* Porter
* Pravega
* sealer
* Serverless Devs
* Serverless Workflow
* Service Mesh Interface (SMI)
* Service Mesh Performance
* Skooner
* Strimzi
* Submariner
* SuperEdge
* Telepresence
* Teller
* Tinkerbell
* Tremor
* Trickster
* Vineyard
* Virtual Kubelet
* wasmCloud
* WasmEdge Runtime