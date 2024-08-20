# Create and Manage a Production Kubernetes Cluster

Chapter 2 opens with the sounds of the ocean breeze, the waves crashing, and the slurping noise of Hero finishing the last of their piña colada. Our hero application is chillin' in their development environment, soaking up the sun alongside their backing service Lil DeeBee the Database Cat, and Hero is able to be natively developed on Kubernetes in a fast-feedback way. Hero is undoubtedly living the good life⎯but after some time, they're ready for bigger and better things. Hero and Lil DeeBee are eager for the next phase of their journey: to move to a production cluster and serve end users!

What does a production cluster have that a development cluster does not? First, a production environment will almost certainly be bigger, because it is built to hold many copies of the same application that scale horizontally as more and more user requests come in. Production clusters can have thousands of nodes! Also, with a development cluster, an organization may choose to be more relaxed with security or may decide not to implement observability. Some companies only do GitOps in production and they don't bother in development. Basically, there is a lot of necessary complexity involved in running an application in production, and although [Twelve-Factor App](https://12factor.net/) methodology advocates for development and production environments to be identical, that's not always how it goes in practice.


**What should one look for in a successful cluster provisioning solution?**

First, it is beneficial if the solution is declarative and Kubernetes-native. This way cluster definitions can be stored in Git and managed with GitOps. GitOps has a host of benefits, including drift detection and reconciliation. Additionally, GitOps provides access to all Kubernetes ecosystem tooling, including observability and policy tools, that can now be used with infrastructure resources. The GitOps approach, GitOps tooling, and GitOps benefits will be discussed further in the next choice in our story. 

Another factor to consider in your cluster provisioning solution is the fact that cluster provisioning can be wildly complex, and folks approach this complexity in different ways. There are several decision points where there is a tradeoff to consider: do you want a more opinionated solution where there are fewer customizations that you can make? Or do you want full control and all of the complexity that comes with it? This decision needs to be made at the cloud provider level (for example, AWS has more “knobs” and therefore requires more cognitive load, and GCP is easier to use but offers fewer options), and again this tradeoff is a consideration when evaluating cluster provisioning tools.

Another question to ask is: who in your organization will be doing the cluster provisioning, and is it important for them to understand the complexity? Some companies have one massive cluster with thousands of nodes. Those cluster operators have the full-time job of understanding and managing their cluster infrastructure. But other companies may have many smaller clusters, perhaps one cluster per team. This strategy involves cluster experts too, people who are concerned with how to manage so many clusters at scale. For example, they're concerned with how to do Kubernetes version upgrades across the many clusters in the organization. But this approach also introduces a cluster user persona (usually a team of app friends) who may need to be able to provision clusters but do not care about the underlying infrastructure choices being made. Does your cluster provisioning solution provide for this persona? To be clear, cluster provisioning is never NOT complex. But with some cluster provisioning tools, the complexity can be hidden for those who don't need to see it. 


[![Provision a Production Cluster - Feat. Crossplane And Cluster API (You Choose!, Ch. 2, Ep. 1)](https://img.youtube.com/vi/lzBWIhYC5_E/0.jpg)](https://youtu.be/lzBWIhYC5_E)

## Choice 1: Cluster API

[Cluster API](https://cluster-api.sigs.k8s.io/) is a Kubernetes sub-project that uses Kubernetes custom resources (and their associated controllers) to manage the lifecycle of Kubernetes clusters. 

Cluster API cares about five cluster characteristics:
* base infrastructure (for example VPC, networking, security groups)
* infrastructure required for Kubernetes (for example physical or virtual machines)
* how to install Kubernetes onto those machines (this is often called “bootstrapping”)
* which Kubernetes distribution (for example Tanzu, OpenShift, or GKE)
* maintaining the desired state of the cluster (“Day 2 operations”)

This seems simple enough but there are many possible technology choices for each of these steps, and a bajillion different combinations of how choices from each step might fit together. Perhaps you want machines running in Google Cloud, and you want your Kubernetes distribution to be Tanzu. Maybe you want to run OpenShift on AWS. Maybe you want a bare metal, air-gapped installation of vanilla Kubernetes installed using the Kubeadm tool.  

Cluster API helps you to define what you want your final cluster to look like in a declarative way. It tackles the complexity of supporting the many options and combinations first by having infrastructure-and-tooling-agnostic, Cluster-API-specific custom resources that are maintained by the project. Notable ones include a **Cluster** custom resource where you can define all of the general configurations for your cluster (it also references infrastructure-specific custom resources, which we will cover momentarily). Another notable Cluster-API custom resource is a **Machine**, which defines what a server should look like in your cluster. In Cluster API, **Machines** are managed by **MachineSets** which are managed by **MachineDeployments**⎯similar to how Pods, ReplicaSets, and Deployments work in Kubernetes. 

Okay- those custom resources seem useful, but how are they addressing the complexity of supporting the gazillion possible manifestations of Kubernetes clusters? That is where the concept of *providers* comes in. The term 'provider' refers to any project that provides functionality to Cluster API. You heard that correctly⎯providers are entirely separate projects from Cluster API. They're not maintained by Cluster API, but they do have to adhere to a core Cluster API contract. Providers are made up of Cluster API-compliant custom resources and their associated controllers, and there are five broad categories of providers. Here are three important ones to know:

1-**Infrastructure providers**. Basically, an infrastructure provider provisions infrastructure resources for the cluster. Examples of cloud infrastructure providers include AWS or GCP. VMware vSphere is an example of a bare metal infrastructure provider. 

2-**Bootstrap providers**. Bootstrap providers each generate instructions to create a Kubernetes cluster and/or to add a machine to a cluster. Then they format the commands so that they can be executed by whatever tool sets up the cluster. Examples of bootstrap providers include Kubeadm or EKS. 

3-**Control plane providers**. Control plane providers are concerned with the Kubernetes control plane and the lifecycle of the control plane nodes. For example, Microk8s or Talos.

So then, when a cluster is created, core Cluster API custom resources are used to orchestrate the infrastructure/tool agnostic parts of building a cluster, and then the Cluster API custom resources reference provider custom resources that each do their part of the infrastructure/tool-specific work. 

Cluster API is a mature project with lots of community support. Because it is declarative, it works well with GitOps. And the Kubernetes control loop can be used to make sure the actual state of the created clusters is always the same as the desired state.

Because the act of creating and maintaining Kubernetes clusters is complex, Cluster API is necessarily complex to learn and use. Additionally, Cluster API currently does not have a way to provision multiple clusters with the same configuration. However, as of this writing (June 2023) Cluster API has an alpha feature called *ClusterClass* which is an object that can be used to stamp out clusters that each have customizable knobs, making it easier to create new clusters.

Cluster API is often abbreviated as CAPI. When folks verbally discuss Cluster API they might refer to it by its abbreviated form which sounds like "Cappy." 


[![How To Create, Provision, And Operate Kubernetes With Cluster API (CAPI)](https://img.youtube.com/vi/8yUDUhZ6ako/0.jpg)](https://youtu.be/8yUDUhZ6ako)
[![What Is Cluster API?](https://img.youtube.com/vi/SWj_DmiUvbc/0.jpg)](https://youtu.be/SWj_DmiUvbc)
* [Official site](https://cluster-api.sigs.k8s.io/)

## Choice 2: Crossplane

At a high level, [Crossplane](https://crossplane.io) is a tool that lets you interact with **any** API via Kubernetes. One popular use case is to use Crossplane to provision and manage Kubernetes clusters. 

In Crossplane, when an infrastructure primitive is brought into Kubernetes as a custom resource, this is called a **managed resource**. A cloud provider might have hundreds of infrastructure primitives (for example AWS has over 800), and these can be brought into your Kubernetes cluster as managed resources by Crossplane **providers**. Providers extend Crossplane by installing controllers for new kinds of managed resources. For example, the AWS provider installs support for all 800+ AWS-managed resources like RESInstances and S3Buckets. 

When you provision a cluster using Crossplane, you have granular control over which managed resources you want to use and how those resources interact with one another. You define all of this in a declarative way using a higher-level abstraction called a **Composite Resource Definition**(XRD). 

A composite resource definition can grow to be very complex because infrastructure itself is very complex. However, with Crossplane you can make a simplified interface for other personas in your organization (for example app developers or data scientists) to be able to create their own clusters in a self-service way, and those clusters will follow all of your specified configurations and best practices. This simplified interface is called a **Composite Resource Claim**(XRC). A composite resource claim exposes only the choices that are relevant to the user and hides the complexity.

With Crossplane, the building blocks (managed resources) are not limited to ones pertaining only to cluster provisioning, or to one particular cloud provider. You could make a composite resource (and corresponding composite resource claim) that offers app developers the choice to make an EKS or a GKE cluster, in the size of small, medium, or large⎯all with one simple interface. Or you could make a composite resource claim (underscored by a full-blown composite resource definition) that offers data scientists the ability to provision a GKE cluster for themselves that comes preconfigured with an instance of CloudSQL and a connection to a running database. 

In fact, with infrastructure building blocks expressed as Kubernetes APIs, that means you can interact with your infrastructure using any tool in the Kubernetes ecosystem. Therefore, with Crossplane you can manage your infrastructure using the same tools that you use to manage your workloads. This opens up new possibilities to manage your infrastructure using Kubernetes tools for GitOps, policy management, observability, and much, much more.

[![Crossplane - GitOps-based Infrastructure as Code through Kubernetes API](https://img.youtube.com/vi/n8KjVmuHm7A/0.jpg)](https://youtu.be/n8KjVmuHm7A)
[![How To Shift Left Infrastructure Management Using Crossplane Compositions](https://img.youtube.com/vi/AtbS1u2j7po/0.jpg)](https://youtu.be/AtbS1u2j7po)
[![Crossplane: Control Plane of Control Planes](https://img.youtube.com/vi/CHBA34a0KEQ/0.jpg)](https://youtu.be/CHBA34a0KEQ)
* [Official site](https://crossplane.io)

## Choice 3: KubeClipper

TODO:

## What is your choice?

* [Cluster API](cluster-api.md)
* [Crossplane](crossplane.md)
* **KubeClipper** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.