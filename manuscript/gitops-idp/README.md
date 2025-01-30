# State Synchronization (GitOps)

There are four [GitOps Principles](https://opengitops.dev/):

1-**Resources Are Defined Declaratively**
A system managed by GitOps must have its desired state expressed declaratively.

2-**Resource Definitions Are Versioned and Immutable**
The desired state is stored in a way that enforces immutability, enforces versioning, and retains a complete version history. Usually, Git is used for this.

3-**Resource Definitions Are Pulled Automatically**
Software agents automatically pull the desired state declarations from the source. Here 'software agents' refers to the GitOps tool and, again, the source is usually Git.

4-**The Desired State Is Continuously Reconciled With the Actual State**
Software agents (GitOps tools) continuously observe the actual system state and attempt to apply the desired state.

## Choice 1: Argo CD

[![What Is Argo CD?](https://img.youtube.com/vi/fQ9846hRiFo/0.jpg)](https://youtu.be/fQ9846hRiFo)
* [DOT Argo Playlist](https://youtube.com/playlist?list=PLyicRj904Z9_dGuNs6AN5Khljjn9ssbQ6)
* [Official site](https://argoproj.github.io/cd)

## Choice 2: Flux

[![Flux CD v2 With GitOps Toolkit - Kubernetes Deployment And Sync Mechanism](https://img.youtube.com/vi/R6OeIgb7lUI/0.jpg)](https://youtu.be/R6OeIgb7lUI)
[![What the Flux?! GitOps at Your Fingertips](https://img.youtube.com/vi/_8Zobz7qbqo/0.jpg)](https://youtu.be/_8Zobz7qbqo)
* [Official site](https://kubevela.io)

## Choice 3: Carvel kapp-controller

[![What Is Carvel kapp-controller?](https://img.youtube.com/vi/ojFG8h5Ht70/0.jpg)](https://youtu.be/ojFG8h5Ht70)
* [Official site](https://carvel.dev/kapp-controller)

## What Is Your Choice?

* [Argo CD](argocd.md)
* [Flux](flux.md)
* **Carvel kapp-controller** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
