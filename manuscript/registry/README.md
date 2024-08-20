# Store Container Image in a Registry

Our hero application's form has leveled up! They are now a container image! Hero is bursting with pride, but it is too soon to celebrate. Right now they still only exist locally, and they need their own place out in the world. A place where they can live and evolve, and from where they can teleport to wherever they are needed. Let's choose a container image registry for Hero! ♪  

A container image registry is a server that stores and serves images. It enables container images to be easily shared between systems. A container image registry can either be public or private. For example, you may pull the latest official public image of Ubuntu from their public registry. In contrast, a private registry might be used to share the latest version of a propietary application between teams within the same company.

[![Store Image in a Registry - Feat. Harbor, Docker Hub, and Dragonfly (You Choose!, Ch. 1, Ep. 2)](https://img.youtube.com/vi/QP8xGYwevKo/0.jpg)](https://youtu.be/QP8xGYwevKo)

## Choice 1: Docker Hub

Docker Hub is a service provided by Docker for finding and sharing container images. Users can store and share images to public repositories for free, or to private repositories for a fee. Docker Hub is the world's largest repository of container images, hosting images from community developers, open source projects, and independent software vendors (ISV). Docker Hub additionally can trigger actions after a successful push to a registry. These webhooks aid in integrating Docker Hub with other tools.

* [Official site](https://hub.docker.com)

## Choice 2: Harbor

Harbor is a CNCF-Graduated, open source container image registry. Harbor has three main features: it secures artificts with policies and role-based access control, ensures that container images are scanned and free from vulnerablities, and signs images as trusted. 

[![Manage Container (Docker) Images, Helm, CNAB, and Other Artifacts With Harbor](https://img.youtube.com/vi/f931M4-my1k/0.jpg)](https://youtu.be/f931M4-my1k)
[![Own Your Images with Harbor](https://img.youtube.com/vi/mXwslv2VAbY/0.jpg)](https://youtu.be/mXwslv2VAbY)
* [Official site](https://goharbor.io)

## Choice 3: Dragonfly

Dragonfly is not a registry per se, it is a file distribution system based on peer-to-peer (P2P) networking. 

Dragonfly additionally has a sub-project called [Nydus](https://nydus.dev/) that is an open source filesystem solution that aids in high-efficiency image distribution.

The Dragonfly/Nydus combo is powerful. 

First because **Nydus-formatted images are made up of smaller pieces that can be moved around independently of one another.** This combined with using Dragonfly's P2P network can take advantage of every node's bandwidth, greatly reducing image pull time.

Second because **Nydus knows which part of the image is essential for the start-up of the container** - maybe only 50 MB of data of a 1 GB image - **and it will begin by just pulling that part so the container can be started.** In this way it greatly reduces the container startup time. This is also good for serverless scenerios.  

* [Dragonfly official site](https://d7y.io)
* [Nydus official site](https://nydus.dev/)

## What Is Your Choice?

**If, during the setup phase, you chose to use `nip.io` instead of a "real" domain, you cannot choose Harbor (without modifying the commands and the manifests).**

* [Docker Hub](docker-hub.md)
* [Harbor](harbor.md)
* [Dragonfly](dragonfly.md)
* **zot** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
