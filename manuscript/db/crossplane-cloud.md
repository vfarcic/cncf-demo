# Setup PostgreSQL DB In Cloud With Crossplane

Some important Crossplane vocabulary:

**`Composition`***
* your connection to managed resources (aka GKE cluster, or AWS S3 bucket, or an Azure PostgreSQL instance, or a SaaS offering, or anything you can think of!)
* you can also connect to arbitrary Kubernetes resources using Kubernetes and Helm providers
* plus there are piles of other providers

**`CompositeResourceDefinition` (XRD)**
* this is where an ops person specifies the details (type/schema) of the developer interface
* it can orchestrate several disparate resources that are referenced and defined via `Composition`s (for example an app running in Kubernetes connecting to a GCP Postgres instance and a New Relic dashboard)
* you can reference multiple `Composition`s here, and in doing so you can make several types of resources from several different places available in one developer interface (for example one simple `CompositeResource` interface can make a cluster available from Google, or Azure, or AWS)

**Composite Resource Claim** (or just *claim*, for short)
* this is not a literal name of a Crossplane custom resource, but a way to refer to the simplified interface that ops folks create for dev folks. The actual Kubernetes custom objects that are created as claims are arbitrarily named by the ops folks who create them.
* allows app friends to provision and manage a `CompositeResource`
* an app friend's simplified interface to a `CompositeResource`, there is likely some (or much) complexity and opinions hidden
* a claim contains a reference to its corresponding `CompositeResource`
* namespaced

**CompositeResource (XR)**
* an instance of a `CompositeResourceDefinition`
* created when an app friend creates a corresponding claim
* similar to a claim, but this resource is ops-facing and has all of the complexity exposed and available to manipulate
* contains a reference to a claim, and an array of references to the managed resources (Compositions) that it composes
* it is optional for a `CompositeResource` to offer a claim at all
* cluster-scoped

**Provider**
* extends Crossplane and provides controllers for new kinds of managed resources
* for example, the AWS provider extends Crossplane so that it supports AWS-managed resources like `RDSInstance` and `S3Bucket`

*Here, `Composition` refers to the specific Crossplane custom resource that connects Crossplane to each of the resources that ultimately make up a higher-level `CompositeResource`. The term 'Composition' can also broadly refer to the feature of Crossplane that allows ops folks to define their own opinionated platform APIs and expose simplified interfaces to app friends (that is how it is used in the title of this section).

## Setup

```bash
chmod +x manuscript/db/crossplane-cloud.sh

./manuscript/db/crossplane-cloud.sh
```

## Which Cloud Provider Do You Use?

* [Google Cloud](crossplane-google.md)
* [AWS](crossplane-aws.md)
* [Azure](crossplane-azure.md)