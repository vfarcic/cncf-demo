# Store Container Image in a Registry

Our hero application's form has leveled up! They are now a container image! Hero is bursting with pride, but it is too soon to celebrate. Right now they still only exist locally, and they need their own place out in the world. A place where they can live and evolve, and from where they can teleport to wherever they are needed. Let's choose a container image registry for Hero! ♪  

TODO: intro to container registry that is generic and applies no matter the tool we choose

## Choice 1: Docker Hub

Docker Hub is a service provided by Docker for finding and sharing container images. Users can store and share images to public repositories for free, or to private repositories for a fee. Docker Hub is the world's largest repository of container images, hosting images from community developers, open source projects, and independent software vendors (ISV). Docker Hub additionally can trigger actions after a successful push to a repository. These webhooks aid in integrating Docker Hub with other tools.

* [Official site](https://hub.docker.com)

## Choice 2: Harbor

Harbor is a CNCF-Graduated, open source container image registry. Harbor has three main features: it secures artificts with policies and role-based access control, ensures that container images are scanned and free from vulnerablities, and signs images as trusted. 

* [Manage Container (Docker) Images, Helm, CNAB, and Other Artifacts With Harbor](https://youtu.be/f931M4-my1k)
* [Official site](https://goharbor.io)

## Choice 3: DragonFly

TODO: Explanation

* [Official site](https://d7y.io)

## What Is Your Choice?

* [Distribution](distribution.md)
* [Harbor](harbor.md)
* [Dragonfly](dragonfly.md)