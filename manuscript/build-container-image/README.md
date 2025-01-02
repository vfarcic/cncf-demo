# Build Container Image in Dev Environments

Our hero begins as humble source code, and to even begin to find production they need to learn to walk. They need to be portable, and to carry their dependencies and lightweight OS with them as they go. Let's get Hero out of the git repository and moving towards bigger and better things!

At its core, a container image is simply a tarball of an entire filesystem (or several tarballs - one for each layer). With containers, application code is packaged up with the operating system and necessary dependencies. That way the application has everything that it needs to run in a consistent and repeatable way, no matter what hardware platform and operating system it is running on. Containers are lightweight and portable because they only contain as much of the operating system as what is needed to run the application. When an application is run in containers it can easily scale, simply by making more instances of the containerized application as traffic increases.

[![Build Container Image - Feat. Carvel kbld, Buildpacks, and Lima (You Choose!, Ch. 1, Ep. 1)](https://img.youtube.com/vi/GDInFocQJTU/0.jpg)](https://youtu.be/GDInFocQJTU)

## Choice 1: Carvel kbld

`kbld` is a CLI that automates image building, image pushing, and deployment configuration updates. `kbld` is part of the [Carvel](https://carvel.dev/) suite of tools. Whenever a relevant new resource is created, `kbld` builds an application image from your specified source code (using Docker or Cloud Native Buildpacks), `kbld` optionally pushes the resulting image to your registry of choice, and finally `kbld` resolves it to an image digest reference. `kbld` automatically finds image references within your configuration, and you can choose whether `kbld` updates these references to the latest image digest or whether to lock a certain image digest reference to ensure that exactly the same image versions are used. `kbld` probably works with your existing configuration management tool (helm, kustomize, ytt, vanilla k8s).

[![Carvel: Clean Tools for Cloud Native Problems](https://img.youtube.com/vi/gsyGOv_Nwb0/0.jpg)](https://youtu.be/gsyGOv_Nwb0)
* [Official site](https://carvel.dev/kbld)

## Choice 2: Lima

Lima is a Linux virtual machine that is optimized to run [containerd](https://containerd.io/) on Mac. The goal of Lima is to promote containerd including `nerdctl` (contaiNERD ctl) to Mac users. containerd is a container runtime that manages the complete container lifecycle--from image transfer and storage, to container execution and supervision, to low-level storage to network attachments. 

If this solution is chosen, we will implement Lima using [Rancher Desktop](https://docs.rancherdesktop.io/). Rancher Desktop (with Lima, containerd, and `nerdctl`) is a CNCF-friendly, free alternative to Docker Desktop.

Since we are talking about building images here, it is worth noting that with this strategy, `nerdctl` is building the image using [BuildKit](https://docs.docker.com/build/buildkit/), which is a Docker project. BuildKit is an improved build solution to replace Docker's legacy builder.

[![How To Replace Docker With nerdctl And Rancher Desktop](https://img.youtube.com/vi/evWPib0iNgY/0.jpg)](https://youtu.be/evWPib0iNgY)
* [Official site](https://github.com/lima-vm/lima)

## Choice 3: Cloud Native Buildpacks (CNB)

The Cloud Native Buildpacks project takes source code as input and then outputs an [Open Container Initiative](https://opencontainers.org/) (OCI)-compliant container image. CNBs provide a sweet, sweet developer experience while giving platform teams more control over how images are built. Cloud Native Buildpacks additionally provide a software bill of materials (SBOM) - no mystery meat in production!  CNB-built images are reproducible and efficient (only changed layers are rebuilt), and they can be rebased easily since the operating system (OS) layer can be patched without requiring an image rebuild. There are many implementations of Cloud Native Buildpacks such as the [pack](https://buildpacks.io/docs/tools/pack/) CLI tool, [kpack](https://buildpacks.io/docs/tools/kpack/), Google [Cloud Run](https://cloud.google.com/run/), or the [Tekton 'Buildpacks' task](https://hub.tekton.dev/tekton/task/buildpacks), to name a few.

[![Container (Docker) Images Without Dockerfile With Buildpacks and kpack](https://img.youtube.com/vi/fbSoKu8NGSU/0.jpg)](https://youtu.be/fbSoKu8NGSU)
[![What Are Cloud Native Buildpacks and How Do They Work?](https://img.youtube.com/vi/-n9H8KnYjVI/0.jpg)](https://youtu.be/-n9H8KnYjVI)
* [Official site](https://buildpacks.io)

## What Is Your Choice?

* [kbld](kbld.md)
* [Lima](lima.md)
* [Cloud Native Buildpacks (CNB)](buildpacks.md)
