# Mutual TLS (mTLS) and Network Policies

In production, some endpoints are exposed to wider communities, perhaps even the entire public. Hero thinks, “Of course! That is how business gets done!” - but Hero also understands that there is much riff-raff out there in the world, people who would gladly harm Hero, Lil DeeBee, other pods, or the system if they’re given a chance. That’s why production has a policy of zero trust. So, while Hero is technically wired up to be able to communicate with every other Pod in the entire Kubernetes cluster, Hero only needs to talk with Lil DeeBee, so it isn’t good practice to keep those lines of communication open to other resident Pods. Hero will never need to talk to those other Pods, therefore allowing those connections will only make the system vulnerable to mistakes or malice. Because of this, Kubernetes has an object called a [NetworkPolicy](https://kubernetes.io/docs/concepts/services-networking/network-policies/) which allows a human to use labels and selectors to restrict what pods have access to what other pods. Smart! And safe. The thing is, a NetworkPolicy object doesn’t have an implementation that is natively part Kubernetes, so we need to add one. 

But, Hero thinks, that is still putting a lot of trust into the pods that Hero is allowed to communicate with. What if Lil DeeBee gets compromised? The lines of communication themselves need protection. That’s where mutual TLS (mTLS) comes in. mTLS uses [X.509 certificates](https://en.wikipedia.org/wiki/X.509) to verify that each message is actually coming from the Pod who says they sent it, and that it hasn’t been tampered with. mTLS will additionally encrypt every message so that if an attacker hijacks it, that malicious actor won’t be able to read it. 

Network Policies and mTLS are often added to a Kubernetes cluster using an application-layer (L7)* service mesh like Linkerd, Istio, or Kuma, but Network Policies and mTLS can also be added using a networking technology like Cilium, or an IP-address-layer (L3)* service mesh like Network Service Mesh. Let’s help Hero figure out which of these technologies to add to the production cluster to implement Network Policies and mTLS, and, in doing so, help to define and secure cluster communication!

\* These “layers” refer to the [Open Systems Interconnection model (OSI model)](https://en.wikipedia.org/wiki/OSI_model)

\*\* Spoiler alert! Each one of these technologies provides security, networking, and observability to your cluster. Today we’re examining the projects through the lenses of security and networking. Observability is wildly important too, but we’re not to that part of the story yet!

[![What Is Mutual TLS (mTLS), Why Do We Need It, And How Do We Get It?](https://img.youtube.com/vi/b38k2GiLDdc/0.jpg)](https://youtu.be/b38k2GiLDdc)
[![Kubernetes Networking](https://img.youtube.com/vi/3G3BNMTx3bE/0.jpg)](https://youtu.be/3G3BNMTx3bE)
[![Kubernetes Network Policies Explained](https://img.youtube.com/vi/18FEA5xXBGY/0.jpg)](https://youtu.be/18FEA5xXBGY)

## Choice 1: Istio

Like [Ingress](manuscript/ingress/README.md) technologies, the L7 service mesh technologies (Linkerd, Istio, Kuma) each act as a *control plane* that does the complicated work of configuring and managing an underlying networking technology (often referred to as the *data plane*). This data plane can also be called a *networking layer*, *service proxy*, or just *proxy*. The job of the data plane is to add security, capture usage data, and, most importantly, actually route the requests.

In this model, the L7 service mesh adds a *sidecar* to each and every Pod that runs in the cluster. A sidecar is an extra container that runs alongside the workload container in a Pod. That sidecar acts as a proxy for all requests to and from the workload container. The sidecar can provide additional security (like mTLS!), observability, and connectivity (like NetworkPolicy implementation!).

Istio is an application layer (L7) service mesh that uses a technology called Envoy as the data plane. Envoy is full-featured and powerful, but also very complex. Istio simplifies the process of configuring and using Envoy. Istio provides a human-friendly, centralized control plane where you can see and manage all of the activity of the Envoy sidecar containers.

It is most efficient to run Istio in Kubernetes, but workloads can run anywhere. Istio can also support VMs as part of the mesh, as well as provide multi-cluster mesh. Istio has a sidecarless model called Ambient Mesh. 


[![Sailing Into a Sea of Microservices With Istio](https://img.youtube.com/vi/W3K2Ufng8Zg/0.jpg)](https://youtu.be/W3K2Ufng8Zg)
* [Official site](https://istio.io)

## Choice 2: Linkerd

To recap: *service mesh* is an infrastructure layer that adds security, networking, and observability uniformly across your entire application and, when done well, across your entire system. These characteristics are not optional; if they’re not added via service mesh, developers have to add them directly to their applications.

Linkerd is a service mesh that emphasizes performance and operational simplicity while still supplying advanced functionality. The secret sauce is that they use a custom-written Rust proxy as the data plane. The Linkerd service proxy was purpose-built for service mesh. This proxy uses about 10% of the resource consumption of Envoy. 

Linkerd has especially good multi-cluster support. With Linkerd 2.14, if your network supports direct pod-to-pod communication between clusters, then Linkerd clusters will all act like one big cluster - no gateways needed!


[![What Is Linkerd Kubernetes Service Mesh? Linkerd Tutorial Part 1](https://img.youtube.com/vi/mDC3KA_6vfg/0.jpg)](https://youtu.be/mDC3KA_6vfg)
[![Linkerd: The Stress-Free Service Mesh](https://img.youtube.com/vi/iCvw3YFNw0E/0.jpg)](https://youtu.be/iCvw3YFNw0E)
* [Official site](https://linkerd.io)

## Choice 3: Network Service Mesh

Network Service Mesh (NSM) introduces a concept called a ‘Network Service’ - a set of connectivity, security, and observability features at layer three (L3) and above, to which workloads may individually connect.

So, instead of connecting workloads at L7 like more traditional service meshes, Network Service Mesh provides the same connectivity, security, and observability - but at L3, the IP packet layer. This frees individual Kubernetes Pods to network with other individual workloads across multiple clusters, clouds, and legacy environments, no gateways are needed! Workloads do this by each connecting to the same Network Service.

Among other things, Network Service Mesh provides a safe way for workloads to network inter-organizationally, for example, if a car company needs to share a service with a car parts supplier.

With application-layer (L7) meshes, workloads are only able to connect to one mesh, and there is generally only one mesh per cluster. With NSM, a workload can connect to many Network Services. That said, Network Service Mesh and application-layer (L7) meshes are complimentary - NSM provides a single, flat L3 connectivity domain across systems, and an application mesh could add, for example, complex routing rules. 


[![Understanding Network Service Mesh](https://img.youtube.com/vi/qiYGhV3s51s/0.jpg)](https://youtu.be/qiYGhV3s51s)
* [Official site](https://networkservicemesh.io)

## Choice 4: Cilium and SPIFFE

Cilium is a networking technology that is focused on solving networking, security, and observability between workloads in cloud and legacy environments, fueled by [eBPF](https://ebpf.io/). eBPF is a kernel technology that enables the user to inspect and manipulate any call to the Linux kernel in a safe and performant way. 

So, unlike the other technologies here, Cilium is doing its thing at the kernel level. Cilium does this by attaching an identity to each workload as it is created, and then watching what kernel-level events each workload generates. Some examples of events include:
* Pod Y talked to Pod X
* Pod X made a call to somewhere outside of the cluster
* Pod Z opened a network socket

Cilium can watch the system with this level of granularity at native kernel speed, providing excellent observability.

As far as security, Cilium uses eBPF to implement Network Policies at the kernel level, evaluating policy for every event that is generated. Cilium considers the packet, not the session, like traditional application-layer (L7) service meshes, so any changes to Network Policy take immediate effect.

Connectivity-wise, Cilium can connect Pods directly to other Pods, unlike traditional [Container Network Interfaces (CNIs)](https://www.cni.dev/), which route requests like this:

Pod1 → Host → IP Tables → Host → Pod2

Cilium can also act as a [kube-proxy](https://kubernetes.io/docs/reference/command-line-tools-reference/kube-proxy/) replacement. With kube-proxy the IP Tables are constantly updating/reloading as changes are made, making the system slow to converge. Using Cilium instead of kube-proxy has several benefits: lower CPU usage, zero convergence time, and atomic networking rules (as opposed to the IP tables being grouped together in one unit), to name a few.

Cilium can also handle traffic encryption, service discovery, advanced load balancing, IPv6, and more.


[![Kubernetes Networking, Security, And Observability With eBPF And Cilium](https://img.youtube.com/vi/sfhRFtYbuyo/0.jpg)](https://youtu.be/sfhRFtYbuyo)
[![Cilium Networking, Security and Observability](https://img.youtube.com/vi/8sSnPI619u4/0.jpg)](https://youtu.be/8sSnPI619u4)
[![Solving for the Bottom Turtle with SPIFFE and SPIRE](https://img.youtube.com/vi/T-LI-evwV0w/0.jpg)](https://youtu.be/T-LI-evwV0w)
* [Official site](https://cilium.io)

## Choice 5: Kuma

Kuma touts itself as a “universal control plane for your service mesh”. It is an application layer (L7) service mesh and, like Istio, Kuma uses Envoy as the underlying networking technology. 

The main differentiator is that Kuma is designed to be run not only on Kubernetes, but also on VMs, on bare metal, or on any combination thereof. This provides connectivity between both legacy and cloud environments which can help with application modernization and/or migration to cloud or multi-cloud.

Besides being a universal mesh, Kuma also provides a simple developer experience, and it works with geographically distributed systems out of the box.


[![Learn Service Mesh With Kuma](https://img.youtube.com/vi/PnD_PHfoN_o/0.jpg)](https://youtu.be/PnD_PHfoN_o)
* [Official site](https://kuma.io)

## What Is Your Choice?

* [Istio](istio.md)
* [Linkerd](linkerd.md)
* **Network Service Mesh** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* [Cilium and SPIFFE](cilium.md)
* **Kuma** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
