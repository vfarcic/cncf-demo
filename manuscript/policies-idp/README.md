# Policies

TODO: Text

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
* [Official site](https://kyverno.io)

## Choice 2: Open Policy Agent (OPA) With Gatekeeper

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


## Choice 5: Kubernetes Validating Admission Policy

ValidatingAdmissionPolicy is a fully declarative and Kubernetes-native way to define rules about what is or is not allowed to happen to an object in Kubernetes. ValidatingAdmissionPolicies offer a declarative, in-process alternative to validating admission webhooks. However, as the name suggests, ValidatingAdmissionPolicy is only used for validating, not mutating.

ValidatingAdmissionPolicies use Common Expression Language (CEL) to declare the validation rules of a policy. CEL is an extensible, low-overhead, declarative language for expression evaluation. CEL is Turing-incomplete which means you can't write general programs with it. This is good because it protects other Kubernetes API-server users from mistakes or malice. 

A ValidatingAdmissionPolicy cannot be used without a ValidatingAdmissionPolicyBinding. A ValidatingAdmissionPolicyBinding object provides scoping - it tells Kubernetes where to use a ValidatingAdmissionPolicy. ValidatingAdmissionPolicyBindings can be parameterized.

[![Kubernetes Validating Admission Policy Changes The Game](https://img.youtube.com/vi/EsZcDUaSUss/0.jpg)](https://youtu.be/EsZcDUaSUss)
[![What Is ValidatingAdmissionPolicy in Kubernetes?](https://img.youtube.com/vi/tZGjr2Kwpls/0.jpg)](https://youtu.be/tZGjr2Kwpls)
* [Official site](https://kubernetes.io/docs/reference/access-authn-authz/validating-admission-policy)

## What Is Your Choice?

* [Kyverno](kyverno.md)
* [Open Policy Agent (OPA) With Gatekeeper](gatekeeper.md)
* **Cloud Custodian** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **Kubewarden** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* [Kubernetes Validating Admission Policy](vap.md)
