# Admission Controller Policies

Hero and Lil DeeBee are doing the thing! They're running in production and serving end users! Ahhhhh, this is the life. However, Hero can't help but notice... this place is kinda rough around the edges. For one thing, it seems like any old workload is allowed to run in here. There are bloated apps taking WAY more resources than they need, apps pulling images from unsafe, public image repositories, and apps who haven't received any traffic in ages - just to name a few of the unsavory characters roaming about. Not to be a snob or anything, but Hero feels like production needs some rules about what objects are allowed to be here. This will help to make production a safe and productive community. So let's help Hero and Lil DeeBee choose a CNCF tool that will implement admission controller policies!

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

### Admission Controllers - What They Are and How They Work

<br>

When you create an admission controller policy, two things happen. 

First, a webhook is created that teaches the kube-API server that when it sees a request that pairs a certain kind of resource with a certain action (for example, create, update, or delete), the kube-API should send that request somewhere. This webhook is called an *admission controller webhook*, and basically, it is configuration for the kube-API server.

Second, the kube-API sends any matching request to the *admission controller* that configured the webhook. The admission controller is a piece of software, and the software itself is different depending on what the tech is. The CNCF technologies that we are evaluating as part of this step each can act as an admission controller. Admission controllers can also be called **policy engines**. 

As a side note, the term *admission controller* is confusing because unlike other types of controllers in Kubernetes, an admission controller does not run as a reconciliation loop. Instead it is activated by the aforementioned admission controller webhooks. 

An admission controller policy is a collection of one or many rules that set expectations for actions that can or cannot happen in a system. 
<br>
<br>

### Validating Admission Controller Policies Vs. Mutating Admission Controller Policies
<br>

An admission controller policy can be either *validating* or mutating.

A *validating* admission controller policy sets rules about whether a certain action is allowed to be performed on a certain resource. After the rule is set, the admission controller software will evaluate any requests that are covered by this policy and return one of two answers: “Yes, this action is allowed to be performed on this resource”, or “No, this action is not allowed to be performed on this resource”. The kube-api will then act accordingly.

Here are some examples of validating admission controller policies:
* Do not allow any images to be run that are not from the company's internal registry
* Require all Pods to specify resource requests and limits
* Only permit access to the system at certain times of day


A *mutating* admission controller policy sets rules about whether a resource should be changed, and if so, how. After the rule is set, the admission controller software will evaluate any requests that are covered by this policy, and then the admission controller might edit the resource before it is further validated and stored in etcd.

Here are some examples of mutating admission controller policies:
* When an ingress object is created in a certain namespace, label it with a certain label
* Inject sidecar containers into pods
* Set specific annotations on all resources
<br>
<br>
## Choice 1: Kyverno

Kyverno is a policy engine that is specifically built for Kubernetes. This has three benefits:

* **Integrates with other tools in the Kubernetes ecosystem** <br>
for example, GitOps tools and observability tools

* **No need to learn a new language** <br>
with Kyverno, policy is written in YAML

* **Universal reasonablity** <br>

Kyverno also has over 280 policies available to the public, many created by the community. Kyverno offers policy reports that decouple policies from policy results, and a CLI that allows you to use Kyverno in your CI/CD pipeline.

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
* **Validating Admission Policy** is a beta feature as of January 2024. Implementation will be added once it goes GA.
