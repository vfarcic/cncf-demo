# Create and Manage Production Kubernetes Cluster

TODO: Intro

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

Okay- those custom resources seem useful, but how are they addressing the complexity of supporting the gazillion possible manifestations of Kubernetes clusters? That is where the concept of *providers* comes in. The term ‘provider’ refers to any project that provides functionality to Cluster API. You heard that correctly⎯providers are entirely separate projects from Cluster API. They’re not maintained by Cluster API, but they do have to adhere to a core Cluster API contract. Providers are made up of Cluster API-compliant custom resources and their associated controllers, and there are three broad categories of providers:

1-**Infrastructure providers**. Basically, an infrastructure provider provisions infrastructure resources for the cluster. Examples of cloud infrastructure providers include AWS or GCP. VMware vSphere is an example of a bare metal infrastructure provider. 

2-**Bootstrap providers**. Bootstrap providers each generate instructions to create a Kubernetes cluster and/or to add a machine to a cluster. Then they format the commands so that they can be executed by whatever tool sets up the cluster. Examples of bootstrap providers include Kubeadm or EKS. 

3-**Control plane providers**. Control plane providers are concerned with the Kubernetes control plane and the lifecycle of the control plane nodes. For example, Microk8s or Talos.

So then, when a cluster is created, core Cluster API custom resources are used to orchestrate the infrastructure/tool agnostic parts of building a cluster, and then the Cluster API custom resources reference provider custom resources that each do their part of the infrastructure/tool-specific work. 

Cluster API is a mature project with lots of community support. Because it is declarative, it works well with GitOps. And the Kubernetes control loop can be used to make sure the actual state of the created clusters is always the same as the desired state.

Because the act of creating and maintaining Kubernetes clusters is complex, Cluster API is necessarily complex to learn and use. Additionally, Cluster API currently does not have a way to provision multiple clusters with the same configuration. However, as of this writing (June 2023) Cluster API has an alpha feature called *ClusterClass* which is an object that can be used to stamp out clusters that each have customizable knobs, making it easier to create new clusters.

Cluster API is often abbreviated as CAPI. When folks verbally discuss Cluster API they might refer to it by its abbreviated form which sounds like "Cappy." 


[![What Is Cluster API?](https://img.youtube.com/vi/ubjwT9Jcgz0/0.jpg)](https://tanzu.vmware.com/developer/tv/enlightning/44/)
* [Official site](https://cluster-api.sigs.k8s.io/)

## Choice 2: Crossplane

TODO: Explanation

[![Crossplane - GitOps-based Infrastructure as Code through Kubernetes API](https://img.youtube.com/vi/n8KjVmuHm7A/0.jpg)](https://youtu.be/n8KjVmuHm7A)
[![How To Shift Left Infrastructure Management Using Crossplane Compositions](https://img.youtube.com/vi/AtbS1u2j7po/0.jpg)](https://youtu.be/AtbS1u2j7po)
[![Crossplane: Control Plane of Control Planes](https://img.youtube.com/vi/CHBA34a0KEQ/0.jpg)](https://via.vmw.com/Crossplane)
* [Official site](https://crossplane.io)

## What Is Your Choice?

* [Cluster API](cluster-api.md)
* [Crossplane](crossplane.md)