# Build Container Image In Dev Environments

Our hero begins as humble source code, and to even begin to find production they need to learn to walk–that is, they need to be portable and lightweight. Let’s get Hero out of the git repository and moving towards bigger and better things!

## Choice 1: Carvel kbld

kbld is a CLI tool that is part of the Carvel suite, and it works with your existing configuration management tool (helm, kustomize, ytt, vanilla k8s). Whenever a relevant new resource is created, kbld builds an application image from your specified source code (using Docker or Cloud Native Buildpacks), pushes the resulting image to your registry of choice, and finally resolves it to an image digest reference. kbld automatically finds image references within your configuration, and you can choose whether kbld updates these references to the latest image or whether to lock a certain image reference to ensure that exactly the same image versions are used.  

* [Official site](https://carvel.dev/kbld)

## Choice 2: Lima

Lima is a Linux virtual machine that is optimized to run [containerd](https://containerd.io/) on Mac. The goal of Lima is to promote containerd including nerdctl (contaiNERD ctl) to Mac users. containerd is an container runtime that manages the complete container lifecycle, from image transfer and storage to container execution and supervision to low-level storage to network attachments and beyond. Wait, did we say *whole* lifecycle? That's not quite right. You cannot use containerd to build images. You'll still need the old-fashioned Docker + Dockerfile for that.

## More info

* [How To Replace Docker With nerdctl And Rancher Desktop](https://youtu.be/evWPib0iNgY)
* [Official site](https://github.com/lima-vm/lima)

## Choice 3: Cloud Native Buildpacks (CNB)

TODO: Explanation

* [Container (Docker) Images Without Dockerfile With Buildpacks and kpack](https://youtu.be/fbSoKu8NGSU)
* [What Are Cloud Native Buildpacks and How Do They Work?](https://tanzu.vmware.com/developer/tv/enlightning/17/)
* [Official site](https://buildpacks.io)

## What Is Your Choice?

* [Lima](lima.md)
* [kbld](kbld.md)
* [Cloud Native Buildpacks (CNB)](buildpacks.md)