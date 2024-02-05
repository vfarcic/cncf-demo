# Kubernetes Scanning

Hero is settling in to production, reclining back, reaching for their piña colada… wait! What’s this?! A bug just scuttled across Hero’s foot! Hero looks around and sees that there are a LOT of bugs here. It is an infestation!

Each of these bugs represents a vulnerability in Hero’s code, or, more likely, a vulnerability in one of Hero’s dependencies, or dependencies of Hero’s dependencies, or infrastructure code dependencies, or any of the underlying code that makes up this entire world of production.

Hero has quite a few bug-related problems, actually. The first one is simply to find them all. There are bugs everywhere! On the walls, under floorboards, in the faucets, in every nook and cranny. Not to mention the multitudes in the yard and trees outside!

Then, once they’re found, how does Hero identify each bug? Just like insect bugs, most code “bugs” are harmless - they can’t be exploited and therefore are not security threats. So Hero needs to figure out which bugs are harmful so they can deal with those ones in particular. Hero has a field guide that they can consult - the [National Vulnerabilities Database](https://nvd.nist.gov/vuln) - but with the sheer number of bugs here, it isn’t reasonable to do this by hand. 

And there is a third problem! Once Hero does figure out which bugs are harmful, how do they prevent that bug in particular from doing harm? Different bugs need to be remediated in different ways. 

This is all terribly tedious work! Surely there are tools in the CNCF landscape that can help! Let’s learn about them now. 

## Choice 1: Kubescape

Kubescape is a tool to help you discover risks and threats in your Kubernetes system. It does vulnerability scanning and configuration scanning, plus it can generate cluster hardening/remediation proposals. 

Kubescape performs vulnerability scans on both container images and running workloads. It uses another open source tool called Grype to do the heavy lifting here, then Kubescape enriches the data and filters out any irrelevant vulnerabilities. Because new vulnerabilities are constantly being found, Kubescape performs ongoing vulnerability scans in workloads against the most recent published security data. 

Kubescape can also scan for security issues in your configuration. All sorts of configuration: Kubernetes infrastructure setup configuration, workload configuration, role-based access control (RBAC) configuration, cloud provider API configuration, and more. Examples of security issues that Kubescape might scan for include whether kube-API uses TLS, whether secrets are encrypted at rest in etcd, whether a workload is running as root, and whether a user has least-privilege access.

Finally, Kubescape monitors your system with the CNCF tool Inspektor Gadget (providing eBPF-powered observability) and then Kubescape can give hardening and/or remediation proposals that detail how to improve the security posture of your cluster. For example, Kubescape might give you a NetworkPolicy proposal for least-privilege access.

Kubescape can be run as a CLI, as a Kubernetes Operator, and it integrates with GitHub Actions.



[![How to Secure Kubernetes Clusters with Kubescape and Armo](https://img.youtube.com/vi/ZATGiDIDBQk/0.jpg)](https://youtu.be/ZATGiDIDBQk)
[![Be a Security Hero with Kubescape as Your Sidekick](https://img.youtube.com/vi/LWmKabIerOQ/0.jpg)](https://youtu.be/LWmKabIerOQ)
* [Official site](https://kubescape.io)

## Choice 2: Snyk

Snyk is a platform that allows you to scan for security vulnerabilities in four places: your code, any open-source dependencies, your container images, and in infrastructure-as-code configurations. Once vulnerabilities are found, Snyk give you tools to prioritize and fix them. 

You can likely interface with Snyk in the way that suits your workflow best, as it offers a Web UI, a CLI, IDE plug-ins, and API endpoints.

* [Official site](https://snyk.io/)

## What Is Your Choice?

* [Kubescape](kubescape.md)
* [Snyk](snyk.md)