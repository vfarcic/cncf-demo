# Store Container Image in a Registry

Our hero application's form has leveled up! They are now a container image! Hero is bursting with pride, but it is too soon to celebrate. Right now they still only exist locally, and they need their own place out in the world. A place where they can live and evolve, and from where they can teleport to wherever they are needed. Let's choose a container image registry for Hero! ♪  

A container image registry is a server that stores and serves images. It enables container images to be easily shared between systems. Uploading an image to a registry is usually referred to as "pushing" and downloading a container image is called "pulling". A container image registry can either be public or private. For example, you may pull the latest official public image of Ubuntu from their public registry. In contrast, a private registry might be used to share the latest version of a propietary application between teams within the same company.

## Choice 1: Docker Hub

Docker Hub is a service provided by Docker for finding and sharing container images. Users can store and share images to public repositories for free, or to private repositories for a fee. Docker Hub is the world's largest repository of container images, hosting images from community developers, open source projects, and independent software vendors (ISV). Docker Hub additionally can trigger actions after a successful push to a registry. These webhooks aid in integrating Docker Hub with other tools.

* [Official site](https://hub.docker.com)

## Choice 2: Harbor

Harbor is a CNCF-Graduated, open source container image registry. Harbor has three main features: it secures artificts with policies and role-based access control, ensures that container images are scanned and free from vulnerablities, and signs images as trusted. 

[![Harbor in 1 Minute](https://img.youtube.com/vi/96U4NumYA-M/0.jpg)](https://youtu.be/96U4NumYA-M)
[![Manage Container (Docker) Images, Helm, CNAB, and Other Artifacts With Harbor](https://img.youtube.com/vi/f931M4-my1k/0.jpg)](https://youtu.be/f931M4-my1k)
[![Own Your Images with Harbor](https://img.youtube.com/vi/mXwslv2VAbY/0.jpg)](https://via.vmw.com/Harbor)
* [Official site](https://goharbor.io)

## Choice 3: DragonFly

Dragonfly is not a registry per se, it is a file distribution system based on peer-to-peer (P2P) networking. 

Dragonfly is useful in distributing container images that need to be made available to all of the nodes of a Kubernetes cluster. For example, Dragonfly can be used to improve the download speeds of container images stored in a local registry in an air-gapped environment. It is also useful to improve cold start times in a use case where an application needs to be able to scale up from zero.

* [Official site](https://d7y.io)

## What Is Your Choice?

**If, during the setup phase, you chose to use `nip.io` instead of a "real" domain, you cannot choose Harbor (without modifying the commands and the manifests).**

* [Docker Hub](docker-hub.md)
* [Harbor](harbor.md)
* [Dragonfly](dragonfly.md)