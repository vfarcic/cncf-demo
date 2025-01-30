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

As a side note, the term *admission controller* is confusing because unlike other types of controllers in Kubernetes, an admission controller does not run as a reconciliation loop. Instead, it is activated by the aforementioned admission controller webhooks. 

An admission controller policy is a collection of one or many rules that set expectations for actions that can or cannot happen in a system. 
<br>
<br>

### Validating Admission Controller Policies Vs. Mutating Admission Controller Policies
<br>

An admission controller policy can be either *validating* or *mutating*.

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
[![No-Code Policy with Kyverno](https://img.youtube.com/vi/ytB_PVCMX9s/0.jpg)](https://youtu.be/ytB_PVCMX9s)
[![Signing And Verifying Container Images With Sigstore Cosign And Kyverno](https://img.youtube.com/vi/HLb1Q086u6M/0.jpg)](https://youtu.be/HLb1Q086u6M)
* [Official site](https://kyverno.io)

## Choice 2: Open Policy Agent (OPA) with Gatekeeper

Open Policy Agent (OPA) is a general-purpose policy engine that allows you to use a unified policy framework across your entire cloud native stack, not just Kubernetes. Besides Kubernetes, you can use OPA to enforce policies in microservices, CI/CD pipelines, API gateways and more. 

Rego is a declarative, purpose-built policy language written specifically for OPA.

OPA Gatekeeper is the go-to project for using OPA as a Kubernetes admission controller. 

Just like Kyverno, OPA has excellent community support (over 150 Rego built-ins!), as well as a CLI to enable you to incorporate policy into your pipeline. 


[![How to apply policies in Kubernetes using Open Policy Agent (OPA) and Gatekeeper](https://img.youtube.com/vi/14lGc7xMAe4/0.jpg)](https://youtu.be/14lGc7xMAe4)
[![Open Policy Agent and Rego - the Policy Power Duo!](https://img.youtube.com/vi/QNX5JfV390c/0.jpg)](https://youtu.be/QNX5JfV390c)
* [Official site](https://open-policy-agent.github.io/gatekeeper)

## Choice 3: Cloud Custodian

Cloud Custodian is a rules engine that helps you to manage your cloud resources by filtering them, tagging them, and then applying actions to your resources. Cloud Custodian policies are written in a high-level YAML DSL that focuses on readability and simplicity. 

Cloud Custodian is meant to help you manage your entire cloud estate, with Kubernetes support in beta (as of January 2024). It can be run locally, on an instance, or serverless in AWS Lambda. 

With Cloud Custodian, there is huge flexibility with what types of cloud resources can be managed, as well as what actions can be applied to those resources. Custodian also can do event-based policies which support both real-time enforement and serverless compute. 

Cloud Custodian also has a wonderful community with over 400 contributors to the project. 


[![Cloud Custodian - Policies? Resource Management? Something Else?](https://img.youtube.com/vi/AuXWI-Mkz9Q/0.jpg)](https://youtu.be/AuXWI-Mkz9Q)
[![Cloud Custodian: Governance as Code That Developers Love](https://img.youtube.com/vi/61m5uH_FPtY/0.jpg)](https://youtu.be/61m5uH_FPtY)
* [Official site](https://cloudcustodian.io)

## Choice 4: Kubewarden

Kubewarden is a policy engine for Kubernetes that allows you to write policies in any language or Domain Specific Language (DSL) that you are familiar with. Kubewarden accomplishes this by building policies using WebAssembly (wasm). 

With WebAssembly, first you write code as usual, but then when you compile it you create a wasm module that you can run on any OS/architecture. With Kubewarden, the wasm module that represents a policy runs as part of its policy engine. Additionally, Kubewarden policies are OCI artifacts and can be distributed using container registries and integrated into CI/CD pipelines. 

All of this enables policy authors to be able to write policies in a programming language that they're comfortable with, using their existing tools and skills, while still providing Kubernetes Operators with all of the functionality that they need to effectively implement cluster-level policies and increase the security and reliability of their system.


[![Kubewarden, the Universal Policy Framework](https://img.youtube.com/vi/HFyLICfbhy8/0.jpg)](https://youtu.be/HFyLICfbhy8)
* [Official site](https://kubewarden.io)

## Choice 5: Validating Admission Policy

ValidatingAdmissionPolicy is a fully declarative and Kubernetes-native way to define rules about what is or is not allowed to happen to an object in Kubernetes. ValidatingAdmissionPolicies offer a declarative, in-process alternative to validating admission webhooks. However, as the name suggests, ValidatingAdmissionPolicy is only used for validating, not mutating.

ValidatingAdmissionPolicies use Common Expression Language (CEL) to declare the validation rules of a policy. CEL is an extensible, low-overhead, declarative language for expression evaluation. CEL is Turing-incomplete which means you can't write general programs with it. This is good because it protects other Kubernetes API-server users from mistakes or malice. 

A ValidatingAdmissionPolicy cannot be used without a ValidatingAdmissionPolicyBinding. A ValidatingAdmissionPolicyBinding object provides scoping - it tells Kubernetes where to use a ValidatingAdmissionPolicy. ValidatingAdmissionPolicyBindings can be parameterized.


[![Kubernetes Validating Admission Policy Changes The Game](https://img.youtube.com/vi/EsZcDUaSUss/0.jpg)](https://youtu.be/EsZcDUaSUss)
[![What Is ValidatingAdmissionPolicy in Kubernetes?](https://img.youtube.com/vi/tZGjr2Kwpls/0.jpg)](https://youtu.be/tZGjr2Kwpls)
* [Official site](https://kubernetes.io/docs/reference/access-authn-authz/validating-admission-policy)

## What Is Your Choice?

* [Kyverno](kyverno.md)
* [Open Policy Agent (OPA) with Gatekeeper](gatekeeper.md)
* [Cloud Custodian](cloud-custodian.md)
* [Kubewarden](kubewarden.md)
* **Validating Admission Policy** is a beta feature as of January 2024. Implementation will be added once it goes GA.
