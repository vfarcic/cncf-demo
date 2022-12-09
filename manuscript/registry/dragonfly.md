# Store Container Image in a Registry with Dragonfly

Dragonfly is a file distribution system based on peer-to-peer (P2P) networking.

Dragonfly is useful in distributing container images that need to be made available to all of the nodes of a Kubernetes cluster. For example, Dragonfly can be used to improve the download speeds of container images stored in a local registry in an air-gapped environment. It is also useful to improve cold start times in a use case where an application needs to be able to scale up from zero (serverless).

**What is peer-to-peer networking?**
In contrast to conventional client-server network systems, with P2P networking all of the computers are connected to one another, and also through a single server computer. The role of the server is usually to help the computers ("peers") find one another. After the peers are found, they communicate directly-the traffic between the peers will not pass through the main server. Regarding sharing information within the network, each device serves the purpose of both the server and the client. Each peer plays an independent role, and has access to save the entire set of shared data in its own database. This enables the speedy transfer of files to and from anywhere in the system.

## Setup

```bash
TODO:
```

## Do

```bash
TODO:
```

## Continue The Adventure

[Define And Deploy The App To Dev](../define-deploy-dev/story.md)

## Undo The Changes

Execute the commands that follow **ONLY** if you want to change your mind and go back.

```bash
TODO:
```
