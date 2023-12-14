# Admission Controller Policies

Hero and Lil DeeBee are doing the thing! They’re running in production and serving end users! Ahhhhh, this is the life. However, Hero can’t help but notice… this place is kinda rough around the edges. For one thing, it seems like any old workload is allowed to run in here. There are bloated apps taking WAY more resources than they need, apps pulling images from unsafe, public image repositories, and apps who haven’t received any traffic in ages—just to name a few of the unsavory characters roaming about. Not to be a snob or anything, but Hero feels like production needs some rules about what objects are allowed to be here. This will help to make production a safe and productive community. So let’s help Hero and Lil DeeBee choose a CNCF tool that will implement admission controller policies!

A policy is an organization-specific rule about what actions (like create, update, delete) are allowed to happen on what objects in a system. An admission controller policy is a rule specifically about what you are allowing into your Kubernetes cluster. 

Admission controller policies are helpful in many ways, such as:

* **Security** <br>
for example, ensuring that Pods do not run in privileged mode

* **Governance** <br>
for example, label every Ingress with a certain label

* **Automation** <br>
for example, when a new namespace is created, add a ConfigMap in that namespace

* **Cost Optimization** <br>
for example, there should not be any services of type LoadBalancer in a given namespace

<br>

## Choice 1: Kyverno

TODO: Explanation

[![Kubernetes-Native Policy Management With Kyverno](https://img.youtube.com/vi/DREjzfTzNpA/0.jpg)](https://youtu.be/DREjzfTzNpA)
[![No-Code Policy with Kyverno](https://img.youtube.com/vi/JsHA1UTxLHQ/0.jpg)](https://youtu.be/JsHA1UTxLHQ)
[![Signing And Verifying Container Images With Sigstore Cosign And Kyverno](https://img.youtube.com/vi/HLb1Q086u6M/0.jpg)](https://youtu.be/HLb1Q086u6M)
* [Official site](https://kyverno.io)

## Choice 2: Open Policy Agent (OPA) with Gatekeeper

TODO: Explanation

[![How to apply policies in Kubernetes using Open Policy Agent (OPA) and Gatekeeper](https://img.youtube.com/vi/14lGc7xMAe4/0.jpg)](https://youtu.be/14lGc7xMAe4)
[![Open Policy Agent and Rego - the Policy Power Duo!](https://img.youtube.com/vi/FlVBw5PNKZQ/0.jpg)](https://youtu.be/FlVBw5PNKZQ)
* [Official site](https://open-policy-agent.github.io/gatekeeper)

## Choice 3: Cloud Custodian

TODO: Explanation

[![Cloud Custodian - Policies? Resource Management? Something Else?](https://img.youtube.com/vi/AuXWI-Mkz9Q/0.jpg)](https://youtu.be/AuXWI-Mkz9Q)
[![Cloud Custodian: Governance as Code That Developers Love](https://img.youtube.com/vi/lv7wR6M9CWk/0.jpg)](https://youtu.be/lv7wR6M9CWk)
* [Official site](https://cloudcustodian.io)

## Choice 4: Kubewarden

TODO: Explanation

[![Kubewarden, the Universal Policy Framework](https://img.youtube.com/vi/bLQ_mtbNRUY/0.jpg)](https://youtu.be/bLQ_mtbNRUY)
* [Official site](https://kubewarden.io)

## Choice 5: Validating Admission Policy

TODO: Explanation

[![Kubernetes Validating Admission Policy Changes The Game](https://img.youtube.com/vi/EsZcDUaSUss/0.jpg)](https://youtu.be/EsZcDUaSUss)
[![What Is ValidatingAdmissionPolicy in Kubernetes?](https://img.youtube.com/vi/Cw_GE6nQPiY/0.jpg)](https://youtu.be/Cw_GE6nQPiY)
* [Official site](https://kubernetes.io/docs/reference/access-authn-authz/validating-admission-policy)

## What Is Your Choice?

* [Kyverno](kyverno.md)
* [Open Policy Agent (OPA) with Gatekeeper](gatekeeper.md)
* [Cloud Custodian](cloud-custodian.md)
* [Kubewarden](kubewarden.md)
* **Validating Admission Policy** is still (June 2023) an alpha feature and, hence, not available in all Kubernetes distributions. Implementation will be added once it goes GA.
