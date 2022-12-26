## The Whole Story

```mermaid
flowchart TD

    subgraph "Legend"
        red(Not yet implemented)
        style red fill:red
        blue{{Make a choice}}
        style blue fill:blue
        transparent(Walk)
    end

    Legend---Development

    subgraph Development
        %% -----------
        %% -- Setup --
        %% -----------
        setup-dev((Setup))
        click setup-dev "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/setup/dev.md"

        %% -- Setup Connections --
        setup-dev-->bci

        %% ---------------------------
        %% -- Build Container Image --
        %% ---------------------------
        bci{{Build Container Image}}
        click bci "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/build-container-image/story.md"
        style bci fill:blue
        bci-kbld(Carvel kbld)
        click bci-kbld "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/build-container-image/kbld.md"
        bci-lima(Lima)
        click bci-lima "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/build-container-image/lima.md"
        bci-buildpacks(Cloud Native Buildpacks / CNB)
        click bci-buildpacks "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/build-container-image/buildpacks.md"

        %% -- Build Container Image Connections --
        bci-->bci-kbld-->registry
        bci-->bci-lima-->registry
        bci-->bci-buildpacks-->registry

        registry{{Store Container Image In A Registry}}
        click registry "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/registry/story.md"
        style registry fill:blue
        registry-distribution(Distribution)
        click registry-distribution "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/registry/distribution.md"
        registry-harbor(Harbor)
        click registry-harbor "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/registry/harbor.md"
        registry-dragonfly(Dragonfly)
        click registry-dragonfly "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/registry/dragonfly.md"
        style registry-dragonfly fill:red

        registry-->registry-distribution-->ddd
        registry-->registry-harbor-->ddd
        registry-->registry-dragonfly-->ddd

        ddd{{Define And Deploy The App To Dev}}
        click ddd "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/define-deploy-dev/story.md"
        style ddd fill:blue
        ddd1(Helm)
        click ddd1 "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/define-deploy-dev/helm.md"
        ddd2(Kustomize)
        click ddd2 "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/define-deploy-dev/kustomize.md"
        ddd3(Carvel)
        style ddd3 fill:red

        ddd-->ddd1-->https
        ddd-->ddd2-->https
        ddd-->ddd3-->https

        https{{Use HTTPS}}
        click https "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/https/story.md"
        style https fill:blue
        https1(HashiCorp Vault)
        click https1 "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/https/vault.md"
        https2(Venafi)
        click https2 "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/https/venafi.md"
        https3(cert-manager)
        click https3 "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/https/cert-manager.md"
        https3-helm(App as Helm)
        click https3-helm "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/https/cert-manager-helm.md"
        https3-kustomize(App as Kustomize)
        click https3-kustomize "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/https/cert-manager-kustomize.md"
        https3-carvel(App as Carvel)
        style https3-carvel fill:red

        https-->https1
        https-->https2
        https-->https3
        https3-->https3-helm-->db
        https3-->https3-kustomize-->db
        https3-->https3-carvel-->db

        %% --------
        %% -- DB --
        %% --------
        db{{Setup PostgreSQL DB In Dev}}
        click db "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/story.md"
        style db fill:blue

        %% -- DB Helm --
        db-helm(Helm Chart)
        click db-helm "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/helm.md"
        db-helm-helm(App as Helm)
        click db-helm-helm "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/helm-helm.md"
        db-helm-kustomize(App as Kustomize)
        click db-helm-kustomize "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/helm-kustomize.md"
        db-helm-carvel(App as Carvel)
        click db-helm-carvel "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/helm-carvel.md"
        style db-helm-carvel fill:red

        %% -- DB Crossplane Local --
        db-crossplane-local(Crossplane Composition In Kubernetes)
        click db-crossplane-local "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-local.md"

        %% -- DB Crossplane Cloud --
        db-crossplane-cloud(Crossplane Composition In Cloud)
        click db-crossplane-cloud "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-cloud.md"
        db-crossplane-google(Google Cloud)
        click db-crossplane-google "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-google.md"
        db-crossplane-aws(AWS)
        click db-crossplane-aws "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-aws.md"
        db-crossplane-azure(Azure)
        click db-crossplane-azure "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-azure.md"

        %% -- DB Crossplane Apps --
        db-crossplane-helm(App as Helm)
        click db-crossplane-helm "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-helm.md"
        db-crossplane-carvel(App as Carvel)
        db-crossplane-kustomize(App as Kustomize)
        click db-crossplane-kustomize "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-kustomize.md"
        click db-crossplane-carvel "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-carvel.md"
        style db-crossplane-carvel fill:red

        %% -- DB Connections --
        db-->db-helm
        db-helm-->db-helm-helm-->db-schema
        db-helm-->db-helm-kustomize-->db-schema
        db-helm-->db-helm-carvel-->db-schema
        db-->db-crossplane-local
        db-crossplane-local-->db-crossplane-helm
        db-crossplane-local-->db-crossplane-kustomize
        db-crossplane-local-->db-crossplane-carvel
        db-->db-crossplane-cloud
        db-crossplane-cloud-->db-crossplane-google
        db-crossplane-google-->db-crossplane-helm
        db-crossplane-google-->db-crossplane-kustomize
        db-crossplane-google-->db-crossplane-carvel
        db-crossplane-cloud-->db-crossplane-aws
        db-crossplane-aws-->db-crossplane-helm
        db-crossplane-aws-->db-crossplane-carvel
        db-crossplane-aws-->db-crossplane-kustomize
        db-crossplane-cloud-->db-crossplane-azure
        db-crossplane-azure-->db-crossplane-helm
        db-crossplane-azure-->db-crossplane-kustomize-->db-schema
        db-crossplane-azure-->db-crossplane-carvel
        db-crossplane-helm-->db-schema
        db-crossplane-kustomize-->db-schema
        db-crossplane-carvel-->db-schema

        db-schema{{Manage DB Schema}}
        click db-schema "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db-schema/story.md"
        style db-schema fill:blue
        db-schema-schemahero(SchemaHero)
        click db-schema-schemahero "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db-schema/schemahero.md"
        db-schema-liquibase(Liquibase)
        click db-schema-liquibase "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db-schema/liquibase.md"
        db-schema-flyway(Flyway)
        click db-schema-flyway "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db-schema/flyway.md"
        db-schema-schemahero-helm(App as Helm)
        click db-schema-schemahero-helm "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db-schema/schemahero-helm.md"
        db-schema-schemahero-kustomize(App as Kustomize)
        click db-schema-schemahero-kustomize "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db-schema/schemahero-kustomize.md"
        db-schema-schemahero-carvel(App as Carvel)
        click db-schema-schemahero-carvel "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db-schema/schemahero-carvel.md"
        style db-schema-schemahero-carvel fill:red

        db-schema-->db-schema-flyway
        db-schema-->db-schema-liquibase
        db-schema-->db-schema-schemahero
        db-schema-schemahero-->db-schema-schemahero-helm-->develop
        db-schema-schemahero-->db-schema-schemahero-kustomize-->develop
        db-schema-schemahero-->db-schema-schemahero-carvel-->develop

        %% -------------
        %% -- Develop --
        %% -------------
        develop{{Develop The App}}
        click develop "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/story.md"
        style develop fill:blue
        telepresence(Telepresence)
        click telepresence "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/telepresence.md"
        devspace(DevSpace)
        click devspace "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/devspace.md"
        okteto(Okteto)
        click okteto "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/okteto.md"

        %% -- Develop DevSpace --
        devspace-kustomize(App as Kustomize)
        click devspace-kustomize "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/devspace-kustomize.md"
        devspace-helm(App as Helm)
        click devspace-helm "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/devspace-helm.md"
        devspace-carvel(App as Carvel)
        click devspace-carvel "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/devspace-carvel.md"
        style devspace-carvel fill:red
        telepresence-kustomize(App as Kustomize)
        click telepresence-kustomize "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/telepresence-kustomize.md"
        style telepresence-kustomize fill:red
        telepresence-helm(App as Helm)
        click telepresence-helm "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/telepresence-helm.md"
        style telepresence-helm fill:red
        telepresence-carvel(App as Carvel)
        click telepresence-carvel "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/telepresence-carvel.md"
        style telepresence-carvel fill:red

        %% -- Develop Connections --
        develop-->telepresence
        develop-->devspace
        develop-->okteto
        devspace-->devspace-kustomize
        devspace-->devspace-helm
        devspace-->devspace-carvel
        telepresence-->telepresence-kustomize
        telepresence-->telepresence-helm
        telepresence-->telepresence-carvel
    end

    Development-->Production

    subgraph Production
        %% -----------
        %% -- Setup --
        %% -----------
        setup-prod((Setup))
        click setup-prod "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/setup/prod.md"

        %% -- Setup Connections --
        setup-prod-->cluster

        %% -------------
        %% -- Cluster --
        %% -------------
        cluster{{Create a Cluster}}
        click cluster "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/cluster/story.md"
        style cluster fill:blue
        cluster-cluster-api(Cluster API)
        click cluster-cluster-api "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/cluster/cluster-api.md"
        cluster-crossplane(Crossplane)
        click cluster-crossplane "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/cluster/crossplane.md"
        cluster-terraform(Terraform)
        click cluster-terraform "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/cluster/terraform.md"

        %% -- Cluster Cluster API --
        cluster-cluster-api-google(Google Cloud)
        click cluster-cluster-api-google "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/cluster/cluster-api-google.md"
        style cluster-cluster-api-google fill:red
        cluster-cluster-api-aws(AWS)
        click cluster-cluster-api-aws "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/cluster/cluster-api-aws.md"
        style cluster-cluster-api-aws fill:red
        cluster-cluster-api-azure(Azure)
        click cluster-cluster-api-azure "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/cluster/cluster-api-azure.md"
        style cluster-cluster-api-azure fill:red

        %% -- Cluster Crossplane --
        cluster-crossplane-google(Google Cloud)
        click cluster-crossplane-google "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/cluster/cluster-crossplane-google.md"
        style cluster-crossplane-google fill:red
        cluster-crossplane-aws(AWS)
        click cluster-crossplane-aws "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/cluster/cluster-crossplane-aws.md"
        cluster-crossplane-azure(Azure)
        click cluster-crossplane-azure "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/cluster/cluster-crossplane-azure.md"
        style cluster-crossplane-azure fill:red

        %% -- Cluster Connections --
        cluster-->cluster-cluster-api
        cluster-->cluster-crossplane
        cluster-->cluster-terraform
        cluster-cluster-api-->cluster-cluster-api-google-->gitops
        cluster-cluster-api-->cluster-cluster-api-aws-->gitops
        cluster-cluster-api-->cluster-cluster-api-azure-->gitops
        cluster-crossplane-->cluster-crossplane-google-->gitops
        cluster-crossplane-->cluster-crossplane-aws-->gitops
        cluster-crossplane-->cluster-crossplane-azure-->gitops

        %% ------------
        %% -- GitOps --
        %% ------------
        gitops{{GitOps}}
        click gitops "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/gitops/story.md"
        gitops-flux(Flux)
        click gitops-flux "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/gitops/flux.md"
        style gitops-flux fill:red
        gitops-argocd(Argo CD)
        click gitops-argocd "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/gitops/argocd.md"
        gitops-rancher-fleet(Rancher Fleet)
        click gitops-rancher-fleet "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/gitops/rancher-fleet.md"
        style gitops-rancher-fleet fill:red

        %% -- GitOps Connections --
        gitops-->gitops-flux-->ingress
        gitops-->gitops-argocd-->ingress
        gitops-->gitops-rancher-fleet

        %% -------------
        %% -- Ingress --
        %% -------------
        ingress{{Ingress}}
        click ingress "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/ingress/story.md"
        style ingress fill:red
        ingress-contour(Contour)
        click ingress-contour "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/ingress/contour.md"
        style ingress-contour fill:red
        ingress-todo1(???)
        style ingress-todo1 fill:red
        ingress-todo2(???)
        style ingress-todo2 fill:red

        %% -- Ingress Connections --
        ingress-->ingress-contour-->app
        ingress-->ingress-todo1-->app
        ingress-->ingress-todo2-->app

        %% ---------
        %% -- App --
        %% ---------
        app{{App}}
        click app "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/app/story.md"
        style app fill:red
        app-helm(App as Helm)
        click app-helm "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/app/helm.md"
        style app-helm fill:red
        app-kustomize(App as Kustomize)
        click app-kustomize "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/app/kustomize.md"
        style app-kustomize fill:red
        app-carvel(App as Carvel)
        click app-carvel "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/app/kustomize.md"
        style app-carvel fill:red

        %% -- App Connections --
        app-->app-helm-->db-production
        app-->app-kustomize-->db-production
        app-->app-carvel-->db-production

        %% --------------
        %% -- Database --
        %% --------------
        db-production{{Database}}
        click db-production "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db-production/story.md"
        style db-production fill:red
        db-production-crossplane-google(Google Cloud with Crossplane)
        click db-production-crossplane-google "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db-production/crossplane-google.md"
        style db-production-crossplane-google fill:red
        db-production-crossplane-aws(AWS with Crossplane)
        click db-production-crossplane-aws "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db-production/crossplane-aws.md"
        style db-production-crossplane-aws fill:red
        db-production-crossplane-azure(Azure with Crossplane)
        click db-production-crossplane-azure "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db-production/crossplane-azure.md"
        style db-production-crossplane-azure fill:red

        %% -- Database Connections --
        db-production-->db-production-crossplane-google
        db-production-->db-production-crossplane-aws
        db-production-->db-production-crossplane-azure

    end

    Production-->Observability

    subgraph Observability
        observability-todo(TODO)
        style observability-todo fill:red
    end

    Observability-->Previews

    subgraph Previews
        previews-todo(TODO)
        style previews-todo fill:red
    end

    Previews-->Security

    subgraph Security
        spiffe(Spiffe)
        style spiffe fill:red

        spire(Spire)
        style spire fill:red

        tuf("The Update Framework (TUF)")
        style tuf fill:red

        %% --------------
        %% -- Policies --
        %% --------------
        policies{{Policies}}
        click policies "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/policies/story.md"
        style policies fill:blue
        policies-kyverno(Kyverno)
        click policies-kyverno "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/policies/kyverno.md"
        style policies-kyverno fill:red
        policies-opa("Open Policy Agent (OPA)")
        click policies-opa "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/policies/opa.md"
        style policies-opa fill:red
        policies-cloud-custodian(Cloud Custodian)
        click policies-cloud-custodian "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/policies/cloud-custodian.md"
        style policies-cloud-custodian fill:red

        %% -- Policies Connections --
        policies-->policies-kyverno
        policies-->policies-opa
        policies-->policies-cloud-custodian
    end

    Security-->Automation

    subgraph Automation
        automation-todo(TODO)
        style automation-todo fill:red
    end

    Automation-->IDP

    subgraph IDP
        backstage(Backstage)
        style backstage fill:red
    end
```

## TODO:

* Contour
* Cortex
* CRI-O
* CubeFS
* Emissary Ingress
* gRPC
* in-toto
* KubeEdge
* Litmus
* Longhorn
* NATS
* Notary
* OpenMetrics
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
* Teller
* Tinkerbell
* Tremor
* Trickster
* Vineyard
* Virtual Kubelet
* wasmCloud
* WasmEdge Runtime
* KEDA (after Prometheus)
* KubeVirt
* k3s
* LinkerD
* Dapr
* Istio
* Falco
* Argo Rollout
* Knative
* KubeVela
* CDK For Kubernetes (cdk8s)
* Argo Workflows
* Keptn
* Argo CD
* Flux
* Argo Workflows
* FluentD
* OpenTelemetry
* Jaeger
* Prometheus
* CoreDNS
* Envoy
* TiKV
* Vitess
* Chaos Mesh
* Cilium
* CloudEvents

* Check whether there are new projects to be added to the "story".
* Add Kubernetes SIG projects to the "story".

## Cannot Be Demoed

* containerd
* etcd
* Rook
* Container Network Interface (CNI)
