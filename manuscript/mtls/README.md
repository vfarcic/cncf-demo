# Mutual TLS (mTLS) and Network Policies

In production, some endpoints are exposed to wider communities, perhaps even the entire public. Hero thinks, “Of course! That is how business gets done!” - but Hero also understands that there is much riff-raff out there in the world, people who would gladly harm Hero, Lil DeeBee, other pods, or the system if they’re given a chance. That’s why production has a policy of zero trust. So, while Hero is technically wired up to be able to communicate with every other Pod in the entire Kubernetes cluster, Hero only needs to talk with Lil DeeBee, so it isn’t good practice to keep those lines of communication open to other resident Pods. Hero will never need to talk to those other Pods, therefore allowing those connections will only make the system vulnerable to mistakes or malice. That’s why Kubernetes has an object called a [NetworkPolicy](https://kubernetes.io/docs/concepts/services-networking/network-policies/) which allows a human to use labels and selectors to restrict what pods have access to what other pods. Smart! And safe. The thing is, a NetworkPolicy object doesn’t have an implementation that is natively part Kubernetes, so we need to add one. 

But, Hero thinks, that is still putting a lot of trust into the pods that Hero is allowed to communicate with. What if Lil DeeBee gets compromised? The lines of communication themselves need protection. That’s where mutual TLS (mTLS) comes in. mTLS uses [X.509 certificates](https://en.wikipedia.org/wiki/X.509) to verify that each message is actually coming from the Pod who says they sent it, and that it hasn’t been tampered with. mTLS will additionally encrypt every message so that if an attacker hijacks it, that malicious actor won’t be able to read it. 

Network Policies and mTLS are often added to a Kubernetes cluster using an application-layer (L7)* service mesh like Linkerd, Istio, or Kuma, but Network Policies and mTLS can also be added using a networking technology like Cilium, or an IP-address-layer (L3)* service mesh like Network Service Mesh. Let’s help Hero figure out which of these technologies to add to the production cluster to implement Network Policies and mTLS, and, in doing so, help to define and secure cluster communication!

\* These “layers” refer to the [Open Systems Interconnection model (OSI model)](https://en.wikipedia.org/wiki/OSI_model)

[![What Is Mutual TLS (mTLS), Why Do We Need It, And How Do We Get It?](https://img.youtube.com/vi/b38k2GiLDdc/0.jpg)](https://youtu.be/b38k2GiLDdc)
[![Kubernetes Networking](https://img.youtube.com/vi/3G3BNMTx3bE/0.jpg)](https://youtu.be/3G3BNMTx3bE)
[![Kubernetes Network Policies Explained](https://img.youtube.com/vi/18FEA5xXBGY/0.jpg)](https://youtu.be/18FEA5xXBGY)

## Choice 1: Istio

TODO: Explanation

[![Sailing Into a Sea of Microservices With Istio](https://img.youtube.com/vi/W3K2Ufng8Zg/0.jpg)](https://youtu.be/W3K2Ufng8Zg)
* [Official site](https://istio.io)

## Choice 2: Linkerd (SMI)

TODO: Explanation

[![What Is Linkerd Kubernetes Service Mesh? Linkerd Tutorial Part 1](https://img.youtube.com/vi/mDC3KA_6vfg/0.jpg)](https://youtu.be/mDC3KA_6vfg)
[![Linkerd: The Stress-Free Service Mesh](https://img.youtube.com/vi/iCvw3YFNw0E/0.jpg)](https://youtu.be/iCvw3YFNw0E)
* [Official site](https://linkerd.io)

## Choice 3: Network Service Mesh

TODO: Explanation

[![Understanding Network Service Mesh](https://img.youtube.com/vi/qiYGhV3s51s/0.jpg)](https://youtu.be/qiYGhV3s51s)
* [Official site](https://networkservicemesh.io)

## Choice 4: Cilium and SPIFFE

TODO: Explanation

[![Kubernetes Networking, Security, And Observability With eBPF And Cilium](https://img.youtube.com/vi/sfhRFtYbuyo/0.jpg)](https://youtu.be/sfhRFtYbuyo)
[![Cilium Networking, Security and Observability](https://img.youtube.com/vi/8sSnPI619u4/0.jpg)](https://youtu.be/8sSnPI619u4)
[![Solving for the Bottom Turtle with SPIFFE and SPIRE](https://img.youtube.com/vi/T-LI-evwV0w/0.jpg)](https://youtu.be/T-LI-evwV0w)
* [Official site](https://cilium.io)

## Choice 5: Kuma

TODO: Explanation

[![Learn Service Mesh With Kuma](https://img.youtube.com/vi/PnD_PHfoN_o/0.jpg)](https://youtu.be/PnD_PHfoN_o)
* [Official site](https://kuma.io)

## What Is Your Choice?

* [Istio](istio.md)
* [Linkerd (SMI)](linkerd.md)
* **Network Service Mesh** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **Cilium and SPIFFE** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **Kuma** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
