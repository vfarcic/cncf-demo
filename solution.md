## The Whole Story

```mermaid
flowchart TD;

    red(Not yet implemented)
    style red fill:red
    blue{{Make a choice}}
    style blue fill:blue
    transparent(Walk)

    start((Start))

    start--->setup

    setup(Setup);
    click setup "vfarcic/cncf-demo/blob/main/manuscript/setup.md" _blank

    setup-->bci

    bci{{Build Container Image}}
    click bci "vfarcic/cncf-demo/blob/main/manuscript/build-container-image/story.md" _blank
    style bci fill:blue
    bci1(Docker)
    click bci1 "vfarcic/cncf-demo/blob/main/manuscript/build-container-image/docker.md" _blank
    bci2(Kaniko)
    click bci2 "vfarcic/cncf-demo/blob/main/manuscript/build-container-image/kaniko.md" _blank
    bci3(Cloud Native Buildpacks / CNB)
    click bci3 "vfarcic/cncf-demo/blob/main/manuscript/build-container-image/buildpacks.md" _blank

    bci-->bci1;
    bci-->bci2;
    bci-->bci3-->registry;

    registry{{Store Container Image In A Registry}}
    click registry "vfarcic/cncf-demo/blob/main/manuscript/registry/story.md" _blank
    style registry fill:blue
    registry1(Docker Hub)
    click registry1 "vfarcic/cncf-demo/blob/main/manuscript/registry/docker-hub.md" _blank
    registry2(Harbor)
    click registry2 "vfarcic/cncf-demo/blob/main/manuscript/registry/harbor.md" _blank
    registry3(AWS Elastic Container Registry / ECR)
    click registry3 "vfarcic/cncf-demo/blob/main/manuscript/registry/ecr.md" _blank

    registry-->registry1;
    registry-->registry2-->ddd;
    registry-->registry3;

    ddd{{Define And Deploy The App To Dev}}
    click ddd "vfarcic/cncf-demo/blob/main/manuscript/define-deploy-dev/story.md" _blank
    style ddd fill:blue
    ddd1(Helm)
    click ddd1 "vfarcic/cncf-demo/blob/main/manuscript/define-deploy-dev/helm.md" _blank
    ddd2(Kustomize)
    click ddd2 "vfarcic/cncf-demo/blob/main/manuscript/define-deploy-dev/kustomize.md" _blank
    ddd3(Carvel)
    style ddd3 fill:red

    ddd-->ddd1-->https;
    ddd-->ddd2-->https;
    ddd-->ddd3-->https;

    https{{Use HTTPS}}
    click https "vfarcic/cncf-demo/blob/main/manuscript/https/story.md" _blank
    style https fill:blue
    https1(HashiCorp Vault)
    click https1 "vfarcic/cncf-demo/blob/main/manuscript/https/vault.md" _blank
    https2(Venafi)
    click https2 "vfarcic/cncf-demo/blob/main/manuscript/https/venafi.md" _blank
    https3(cert-manager)
    click https3 "vfarcic/cncf-demo/blob/main/manuscript/https/cert-manager.md" _blank
    https3-helm(Helm)
    click https3-helm "vfarcic/cncf-demo/blob/main/manuscript/https/cert-manager-helm.md" _blank
    https3-kustomize(Kustomize)
    click https3-kustomize "vfarcic/cncf-demo/blob/main/manuscript/https/cert-manager-kustomize.md" _blank
    https3-carvel(Carvel)
    style https3-carvel fill:red

    https-->https1;
    https-->https2;
    https-->https3;
    https3-->https3-helm-->db;
    https3-->https3-kustomize-->db;
    https3-->https3-carvel-->db;

    db{{Setup PostgreSQL DB}}
    click db "vfarcic/cncf-demo/blob/main/manuscript/db/story.md" _blank
    style db fill:blue
    db-helm(Helm Chart)
    click db-helm "vfarcic/cncf-demo/blob/main/manuscript/db/helm.md" _blank
    style db-helm fill:red
    db-crossplane-local(Crossplane Composition In Kubernetes)
    click db-crossplane-local "vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-local.md" _blank
    style db-crossplane-local fill:red
    db-crossplane-google(Crossplane Composition In Google Cloud)
    click db-crossplane-google "vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-google.md" _blank
    style db-crossplane-google fill:red

    db-->db-helm;
    db-->db-crossplane-local;
    db-->db-crossplane-google;
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