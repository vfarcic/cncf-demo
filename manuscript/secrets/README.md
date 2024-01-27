# Managing Secrets in Kubernetes

In production, Hero and Lil DeeBee find themselves dealing with a lot of sensitive data. Mostly credentials really, because every time one of Hero’s processes needs to interact with another entity they have to prove (1) that they are who they say they are (authentication), and (2) that they have permission to access that entity (authorization). So Hero has a key ring jingling with API keys and encryption keys, a pirate chest overflowing with the tokens and passwords they need, and a file cabinet bursting with their certificates and image pull secrets. 

These are all of Hero’s secrets, and they know it is absolutely vital to keep each one secret, but it is all so hard to manage! For one, the secrets are constantly expiring and being replaced, how should Hero deal with that? And Hero’s replicas need to access and use many of the same secrets, how can an organization safely distribute secrets to all of the people and processes who need them (and no one who doesn’t)? How can Hero store the secrets safely while keeping them easy to access when needed? What happens when a secret inevitably gets into the wrong hands, does Hero have a remediation plan?

Many of these problems can be solved with a vault. A vault is a piece of software that stores secrets safely and has an API to interact with it—and probably has other functionality too, depending on the implementation. Some examples of vaults are Hashicorp Vault, Google Secrets Manager, and Azure Key Vault.

However, there are still many considerations, for example, how can Hero safely bring secrets from a vault into their Kubernetes production environment, and rotate those secrets when the old ones expire? How should Hero safely reference secrets in their configuration files? How can Hero centralize the management of their secrets when those secrets come from many different vaults across the organization?

Let’s explore some secrets management tools that help with these issues.

## Choice 1: External Secrets Operator (ESO)

External Secrets Operator (ESO) is a Kubernetes operator that talks to a vault API and does the following:
* retrieves a secret
* stores the secret in Kubernetes
* manages the lifecycle of the Kubernetes secret

As of January 2024, ESO has some enticing Alpha features too, including the ability to generate a secret and store it as a Kubernetes Secret object (to create pull secrets for container registries, for example), and functionality to read a Kubernetes Secret and store it in a vault, which is helpful to replicate secrets between clusters or to create backups of Kubernetes Secrets. 

[![Manage Kubernetes Secrets With External Secrets Operator (ESO)](https://img.youtube.com/vi/SyRZe5YVCVk/0.jpg)](https://youtu.be/SyRZe5YVCVk)
[![Exploring External Secrets Operator (ESO)](https://img.youtube.com/vi/kK4hwXisW8g/0.jpg)](https://youtu.be/kK4hwXisW8g)
* [Official site](https://external-secrets.io)

## Choice 2: Secrets Store CSI Driver (SSCSID)

Container Storage Interface (CSI) is a standard interface between Kubernetes and external storage vendors. Secrets Store CSI Driver uses this interface to enable Kubernetes to mount secrets from vaults directly into pods as storage volumes.

Secrets Store CSI Driver integrates vaults into Kubernetes by mounting a temporary filesystem volume with the secret(s) from the vault into the workload pod, bypassing the need to store secrets directly in Kubernetes, as Kubernetes Secrets. SSCSID additionally uses workload pod identity to access the vault, so it only can access what that pod needs and nothing more.

[![Eliminate Kubernetes Secrets With Secrets Store CSI Driver (SSCSID)](https://img.youtube.com/vi/DsQu66ZMG4M/0.jpg)](https://youtu.be/DsQu66ZMG4M)
[![Keeping Secrets Secret: Secrets Store CSI Driver](https://img.youtube.com/vi/Fn9VLfw5AhE/0.jpg)](https://youtu.be/Fn9VLfw5AhE)
* [Official site](https://secrets-store-csi-driver.sigs.k8s.io)

## What Is Your Choice?

* [External Secrets Operator (ESO)](eso.md)
* [Secrets Store CSI Driver (SSCSID)](sscsid.md)
