# Define and Deploy the App to Dev

TODO: Intro

## Choice 1: Helm

TODO: Explanation

[![You're at the Helm](https://img.youtube.com/vi/oPIiX6vyih8/0.jpg)](https://via.vmw.com/Helm)
* [Official site](https://helm.sh)

## Choice 2: Kustomize

TODO: Explanation

[![Kustomize - How to Simplify Kubernetes Configuration Management](https://img.youtube.com/vi/Twtbg6LFnAg/0.jpg)](https://youtu.be/Twtbg6LFnAg)
[![What Is Kustomize?](https://img.youtube.com/vi/C8DpFc4zw80/0.jpg)](https://youtu.be/C8DpFc4zw80)
* [Official site](https://kustomize.io)

## Choice 3: Carvel ytt

`ytt` is a tool for YAML shaping that is part of the open source [Carvel](https://carvel.dev/) suite. With `ytt` you can template and overlay Kubernetes configuration via YAML structures, not text documents. This is because `ytt` understands YAML on a structural level which eliminates the need to count spaces, or for manual escaping.

With `ytt`, you can:
* **add programming logic to your YAML** - for example, you can externalize values to variables, extract repeated snippets to functions, and make whole sections conditional. `ytt` does this using a Python-like language called Starlark. 

* **patch YAML files** - this means you can use ‘overlay’ YAML files to modify base YAML files. With patching, you can do things like matching, inserting, replacing, or removing items.

* **make YAML files into reusable templates**

* **flexibly expresses configuration without restricting what modifications can be made later** - for example, you can use a small number of base configurations for many environments, where the variations for each environment are stored in purposeful files or directories containing only the necessary differences.

[![Carvel ytt Instead Of Helm? A Better Way To Manage Kubernetes Resources?](https://img.youtube.com/vi/DLnXkH2keNg/0.jpg)](https://youtu.be/DLnXkH2keNg)
[![Carvel: Clean Tools for Cloud Native Problems](https://img.youtube.com/vi/gsyGOv_Nwb0/0.jpg)](https://via.vmw.com/carvel)
* [Official site](https://carvel.dev)

## Choice 4: CDK For Kubernetes (cdk8s)

Cloud Development Kit (CDK) for Kubernetes (cdk8s) is an open source software development framework for defining Kubernetes applications using familiar programming languages. cdk8s enables organizations to improve developer experience where devs can write Kubernetes application configuration in a language they're comfortable with, and without having to have a deep understanding of Kubernetes. Organizations are able to additionally use cdk8s to incorporate guardrails, best practices, and policy enforcement into developer workflows. 

cdk8s runs locally in your development environment, and it produces plain Kubernetes yaml that can be applied to any cluster.  

cdk8s currently supports Typescript, JavaScript, Java, Python, and Go. Support for more languages is coming soon. 

[![cdk8s - Kubernetes Manifests With GoLang, TypeScript, Python And Java](https://img.youtube.com/vi/F2DKtax0NLU/0.jpg)](https://youtu.be/F2DKtax0NLU)
[![What is cdk8s?](https://img.youtube.com/vi/GCZgLmksJW8/0.jpg)](https://via.vmw.com/cdk8s)
* [Official site](https://cdk8s.io)

## What Is Your Choice?

* [Helm](helm.md)
* [Kustomize](kustomize.md)
* [Carvel ytt](carvel-ytt.md)
* [CDK For Kubernetes (cdk8s)](cdk8s.md)