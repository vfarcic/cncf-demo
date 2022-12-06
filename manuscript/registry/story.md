# Store Container Image in a Registry

Our hero application's form has leveled up! They are now a container image! Hero is bursting with pride, but it is too soon to celebrate. Right now they still only exist locally, and they need their own place out in the world. A place where they can live and evolve, and from where they can teleport to wherever they are needed. Let's choose a container image registry for Hero! ♪  

A container image registry is a server that stores and serves images. It enables container images to be easily shared between systems. Uploading an image to a registry is usually referred to as "pushing" and downloading a container image is called "pulling". A container image registry can either be public or private. For example, you may pull the latest official public image of Ubuntu from their public registry. In contrast, a private registry might be used to share the latest version of a propietary application between teams within the same company.

## Choice 1: Docker Hub

Docker Hub is a service provided by Docker for finding and sharing container images. Users can store and share images to public repositories for free, or to private repositories for a fee. Docker Hub is the world's largest repository of container images, hosting images from community developers, open source projects, and independent software vendors (ISV). Docker Hub additionally can trigger actions after a successful push to a repository. These webhooks aid in integrating Docker Hub with other tools.

* [Official site](https://hub.docker.com)

## Choice 2: Harbor

Harbor is a CNCF-Graduated, open source container image registry. Harbor has three main features: it secures artificts with policies and role-based access control, ensures that container images are scanned and free from vulnerablities, and signs images as trusted. 

* [Manage Container (Docker) Images, Helm, CNAB, and Other Artifacts With Harbor](https://youtu.be/f931M4-my1k)
* [Official site](https://goharbor.io)

## Choice 3: DragonFly

Dragonfly is not a registry per se, it is a file distribution system based on peer-to-peer (P2P) networking. In contrast to conventional client-server network systems, with P2P networking all of the computers are connected to one another, and also through a single server computer. The role of the server is usually to help the computers ("peers") find one another. After the peers are found, they communicate directly, the traffic between the peers will not pass through the main server. Regarding sharing information within the network, each device serves the purpose of both the server and the client. Each peer plays an independent role, and has access to save the entire set of shared data in its own database. This enables the speedy transfer of files to and from anywhere in the system.

Dragonfly is useful in distributing container images that need to be made available to all of the nodes of a Kubernetes cluster. For example, Dragonfly can be used to improve the download speeds of container images stored in a local registry in an air-gapped environment. It is also useful to improve cold start times in a use case where an application needs to scale up from zero.

* [Official site](https://d7y.io)

## What Is Your Choice?

* [Distribution](distribution.md)
* [Harbor](harbor.md)
* [Dragonfly](dragonfly.md)