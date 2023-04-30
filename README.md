# Choose Your Own Adventure: The Treacherous Trek to Production

From the moment of their inception as source code on the developer’s laptop, our hero knows that they are destined for great things. They long to be a real, running application, living in production, serving end users! But the epic journey to production is an arduous one, filled with cascading choices—choices concerning app design, testing, security, container image building, deployment strategy, and observability, to name a few. And who knows what other unseen forces lurk in the shadows! One wrong step could be catastrophic.

## Pitch

It is up to us, the audience, to guide our hero; and to help them grow from source code to container image, to their final form as a running application in production. In this ‘Choose Your Own Adventure’-style journey, Whitney and Viktor will present a linear view of all of the choices that an anthropomorphized application must make as they try to find their way to the fabled land of production. Throughout the trek, the audience will vote to choose which path our hero application will take. Can we navigate CNCF projects and avoid pitfalls and dead-ends to get our application to production?

Join us if you dare!  This is not for the faint of heart!

## Rules

* Non-CNCF projects lead to a dead end ☠

## The Adventure!

The best place to start the adventure is the beginning. Perform the [setup](manuscript/setup/dev.md) steps and, from there, start the first chapter by going to [Build Container Image In Dev Environments](manuscript/build-container-image/README.md). As an alternative, you can use graph below to navigate through the adventure.

Almost all items in the graphs contain a link if you prefer to jump straight into a specific part of the adventure. If you do so, please note that the steps work only if one start from the beginning of any of the chapters (e.g., Development, Production, etc.).

*For reasons I cannot explain, the links do not work if they are not opened in a separate tab.*

```mermaid
flowchart TD

    subgraph "Legend"

        red(Not yet implemented)
        style red fill:red
        blue{{Make a choice}}
        style blue fill:blue
        blue(Chosen by viewers)
        style blue fill:green

    end
```

```mermaid
flowchart TD

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
        click bci "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/build-container-image/README.md"
        style bci fill:blue
        bci-kbld(Carvel kbld)
        click bci-kbld "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/build-container-image/kbld.md"
        bci-lima(Lima)
        click bci-lima "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/build-container-image/lima.md"
        bci-buildpacks(Cloud Native Buildpacks / CNB)
        style bci-buildpacks fill:green
        click bci-buildpacks "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/build-container-image/buildpacks.md"

        %% -- Build Container Image Connections --
        bci --> bci-kbld & bci-lima & bci-buildpacks --> registry

        %% -----------------------------------------
        %% -- Store Container Image in a Registry --
        %% -----------------------------------------
        registry{{Store Container Image In A Registry}}
        click registry "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/registry/README.md"
        style registry fill:blue
        registry-docker-hub(Docker Hub)
        click registry-docker-hub "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/registry/docker-hub.md"
        registry-harbor(Harbor)
        click registry-harbor "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/registry/harbor.md"
        style registry-harbor fill:green
        registry-dragonfly(Dragonfly)
        click registry-dragonfly "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/registry/dragonfly.md"
        registry --> registry-docker-hub & registry-harbor & registry-dragonfly --> ddd

        %% --------------------------------------
        %% -- Define And Deploy The App To Dev --
        %% --------------------------------------
        ddd{{Define And Deploy The App To Dev}}
        click ddd "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/define-deploy-dev/README.md"
        style ddd fill:blue
        ddd-helm(Helm)
        click ddd-helm "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/define-deploy-dev/helm.md"
        ddd-kustomize(Kustomize)
        click ddd-kustomize "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/define-deploy-dev/kustomize.md"
        ddd-carvel(Carvel ytt)
        click ddd-carvel "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/define-deploy-dev/carvel-ytt.md"
        style ddd-carvel fill:green
        ddd-cdk8s("CDK For Kubernetes (cdk8s)")
        click ddd-cdk8s "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/define-deploy-dev/cdk8s.md"
        ddd --> ddd-helm & ddd-kustomize & ddd-carvel & ddd-cdk8s --> https

        %% ---------------
        %% -- Use HTTPS --
        %% ---------------
        https{{Use HTTPS}}
        click https "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/https/README.md"
        style https fill:blue
        https-cert-manager(cert-manager)
        click https-cert-manager "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/https/cert-manager.md"
        style https-cert-manager fill:green
        https-cert-manager-helm(App as Helm)
        click https-cert-manager-helm "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/https/cert-manager-helm.md"
        https-cert-manager-kustomize(App as Kustomize)
        click https-cert-manager-kustomize "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/https/cert-manager-kustomize.md"
        https-cert-manager-carvel(App as Carvel ytt)
        click https-cert-manager-kustomize "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/https/cert-manager-carvel.md"
        style https-cert-manager-carvel fill:green
        https-cert-manager-cdk8s(App as cdk8s)
        click https-cert-manager-cdk8s "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/https/cert-manager-cdk8s.md"
        https--> https-cert-manager--> https-cert-manager-helm & https-cert-manager-kustomize & https-cert-manager-carvel & https-cert-manager-cdk8s --> db

        %% --------------------------------
        %% -- Setup PostgreSQL DB In Dev --
        %% --------------------------------
        db{{Setup PostgreSQL DB In Dev}}
        click db "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/README.md"
        style db fill:blue
        db-helm(Helm Chart)
        click db-helm "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/helm.md"
        db-helm-helm(App as Helm)
        click db-helm-helm "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/helm-helm.md"
        db-helm-kustomize(App as Kustomize)
        click db-helm-kustomize "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/helm-kustomize.md"
        db-helm-cdk8s(App as cdk8s)
        click db-helm-cdk8s "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/helm-cdk8s.md"
        db-helm-carvel(App as Carvel ytt)
        click db-helm-carvel "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/helm-carvel.md"
        db-crossplane-local(Crossplane Composition In Kubernetes)
        click db-crossplane-local "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-local.md"
        db-crossplane-cloud(Crossplane Composition In Cloud)
        click db-crossplane-cloud "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-cloud.md"
        style db-crossplane-cloud fill:green
        db-crossplane-google(Google Cloud)
        click db-crossplane-google "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-google.md"
        db-crossplane-aws(AWS)
        click db-crossplane-aws "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-aws.md"
        style db-crossplane-aws fill:green
        db-crossplane-azure(Azure)
        click db-crossplane-azure "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-azure.md"
        db-crossplane-helm(App as Helm)
        click db-crossplane-helm "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-helm.md"
        db-crossplane-carvel(App as Carvel ytt)
        click db-crossplane-carvel "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-carvel.md"
        style db-crossplane-carvel fill:green
        db-crossplane-kustomize(App as Kustomize)
        click db-crossplane-kustomize "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-kustomize.md"
        db-crossplane-cdk8s(App as cdk8s)
        click db-crossplane-cdk8s "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db/crossplane-cdk8s.md"
        db --> db-helm & db-crossplane-local & db-crossplane-cloud
        db-helm --> db-helm-helm & db-helm-kustomize & db-helm-cdk8s & db-helm-carvel --> db-schema
        db-crossplane-local --> db-crossplane-helm & db-crossplane-kustomize & db-crossplane-cdk8s & db-crossplane-carvel
        db-crossplane-cloud --> db-crossplane-google & db-crossplane-aws & db-crossplane-azure --> db-crossplane-helm & db-crossplane-kustomize & db-crossplane-cdk8s & db-crossplane-carvel --> db-schema

        %% ----------------------
        %% -- Manage DB Schema --
        %% ----------------------
        db-schema{{Manage DB Schema}}
        click db-schema "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db-schema/README.md"
        style db-schema fill:blue
        db-schema-schemahero(SchemaHero)
        click db-schema-schemahero "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db-schema/schemahero.md"
        style db-schema-schemahero fill:green
        db-schema-liquibase(Liquibase)
        click db-schema-liquibase "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db-schema/liquibase.md"
        db-schema-schemahero-helm(App as Helm)
        click db-schema-schemahero-helm "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db-schema/schemahero-helm.md"
        db-schema-schemahero-kustomize(App as Kustomize)
        click db-schema-schemahero-kustomize "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db-schema/schemahero-kustomize.md"
        db-schema-schemahero-cdk8s(App as cdk8s)
        click db-schema-schemahero-cdk8s "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db-schema/schemahero-cdk8s.md"
        db-schema-schemahero-carvel(App as Carvel ytt)
        click db-schema-schemahero-carvel "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/db-schema/schemahero-carvel.md"
        style db-schema-schemahero-carvel fill:green
        db-schema --> db-schema-liquibase & db-schema-schemahero
        db-schema-schemahero --> db-schema-schemahero-helm & db-schema-schemahero-kustomize & db-schema-schemahero-cdk8s & db-schema-schemahero-carvel --> develop

        %% ---------------------
        %% -- Develop The App --
        %% ---------------------
        develop{{Develop The App}}
        click develop "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/README.md"
        style develop fill:blue
        develop-telepresence(Telepresence)
        click develop-telepresence "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/telepresence.md"
        develop-devspace(DevSpace)
        click develop-devspace "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/devspace.md"
        style develop-devspace fill:green
        develop-nocalhost(Nocalhost)
        click develop-nocalhost "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/nocalhost.md"
        develop-devspace-kustomize(App as Kustomize)
        click develop-devspace-kustomize "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/devspace-kustomize.md"
        develop-devspace-cdk8s(App as cdk8s)
        click develop-devspace-cdk8s "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/devspace-cdk8s.md"
        develop-devspace-helm(App as Helm)
        click develop-devspace-helm "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/devspace-helm.md"
        develop-devspace-carvel(App as Carvel ytt)
        click develop-devspace-carvel "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/devspace-carvel.md"
        style develop-devspace-carvel fill:green
        develop-devfile(Devfile)
        click develop-devfile "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/develop/devfile.md"
        style develop-devfile fill:red
        develop --> develop-telepresence & develop-devspace & develop-nocalhost & develop-devfile
        develop-telepresence & develop-nocalhost & develop-devfile --> continue
        develop-devspace --> develop-devspace-kustomize & develop-devspace-cdk8s & develop-devspace-helm & develop-devspace-carvel --> continue

        continue((The be continued...))

    end

    Development-->Destroy

    subgraph Destroy

        destroy((Destroy Everything))
        click destroy "https://github.com/vfarcic/cncf-demo/blob/main/manuscript/destroy-dev.md"

    end
```

## Episodes

### Development

| Name | Guests | Date | Link |
| --- | --- | --- | --- |
| Build Container Image | Cora Iberkleid - Carvel kbld<br />Ryan Moran - Buildpacks<br />Anders Björklund - Lima | Wednesday, February 8, 2023 | [story](manuscript/build-container-image/README.md) |
| Store Container Image in a Registry | Vadim Bauer - Harbor<br />Allen Sun - Dragonfly<br />| Tuesday, February 14, 2023 | [story](manuscript/registry/README.md) |
| Define and Deploy the App to Dev | Andrew Block - Helm<br />Scott Rosenberg - Carvel ytt<br />Eli Polonsky - cdk8s<br />Thomas Vitale - Kustomize<br /> | Tuesday, February 21, 2023 | [story](manuscript/define-deploy-dev/README.md) |
| Use HTTPS | Ashley Davis - cert-manager<br /> | Tuesday, February 28, 2023 | [story](manuscript/https/README.md) |
| Set Up PostgreSQL DB in the Dev Environment | Dan Magnum - Crossplane<br />Andrew Block - Helm<br /> | Tuesday, March 7, 2023 | [story](manuscript/db/README.md) |
| Manage DB Schema | Marc Campbell - SchemaHero<br />Robert Reeves - Liquibase<br /> | Tuesday, March 14, 2023 | [story](manuscript/db-schema/README.md) |
| Develop the App | Nick Powell - Telepresence<br />Carl Montanari - DevSpace<br />Elson Yuen - Devfile<br /> | Tuesday, March 21, 2023 | [story](manuscript/develop/README.md) |
| Chapter 1 Finale! | Just Whitney and Viktor! | Tuesday, March 28, 2023 |  |

### Production

| Name | Guests | Date | Link |
| --- | --- | --- | --- |
| Cluster | TODO: - KubeVela With Terraform<br />TODO: - Crossplane<br />TODO: - Cluster API | | [story](manuscript/cluster/README.md) |
| GitOps | TODO: - Flux<br />TODO: - Argo CD<br />TODO: - Carvel kapp-controller | | [story](manuscript/gitops/README.md) |
| Ingress | TODO: - Contour With Envoy<br />TODO: - NGINX<br />TODO: - Emissary-ingress With Envoy | | [story](manuscript/ingress/README.md) |
| Deploy The App To Production & Database | N/A | | [story](manuscript/ingress/README.md) |
| Chapter 2 Finale! | Just Whitney and Viktor! | |  |

## The Format

* Recap of the decisions made in the app's journey so far (<=5 min.)
* Recap of the technology that was chosen from last week's episode (<=5 min.)
* Implement said technology (<=5 min.)
* Intro current episode: why is this step necessary? (<=5 min.)
* Introduce guests
* Each case presented in <= 5 min.
* Audience questions
* Call for voting
* Closing case presentations (20 sec.)
