# Define and Deploy the App to Dev

Our hero application is a container image, and has a home in a registry. Now they have eyes on a development environment. But in order to run in the environment, a lot of choices need to be made and documented. Like, a LOT of choices. Hero's head is spinning!

The act of specifying these choices can be referred to as *configuring* or *defining* the application. The majority of cloud native platforms and frameworks define their configurations via YAML files.  It is best practice to define your application declaratively in a way that can be stored and versioned.

When defining an application, what types of things need to get configured, exactly? There is much to consider. 

[![Define And Deploy Apps - Feat. Helm, Kustomize, Carvel ytt, and cdk8s (You Choose!, Ch. 1, Ep. 3)](https://img.youtube.com/vi/QwU3JmjyKoM/0.jpg)](https://youtu.be/QwU3JmjyKoM)

### Things that need to get defined

* **Container images** - When defining an application, you need to declare which container image you want to run, and from what registry. Do you need to configure credentials to access this registry? It is also wise to consider what your strategy is for updating the `image` values in your configuration as the application evolves - how do you ensure that you are always running the container image that you intend to run?

* **Application-specific configuration** - This includes environment-dependent values that are used by the application. An example would be if your application needs to connect to a certain database in development but then a different database in production. Also what other applications and third-party services are supporting this application? How does this application connect to those, and with what credentials?

* **Infrastructure configuration** - On what physical infrastructure does this application run? In your company's data center, or in the cloud?  If the cloud, which provider? Under what account? How is the compute accessed and manipulated every time a change needs to be made? How are permissions given and managed?

* **Kubernetes-specific components** - Kubernetes itself has many resource objects that help to describe an application deployment - these need to be defined and managed too. Some examples are Deployments, Roles, Namespaces, Services, Persistent Volume Claims, ConfigMaps, and ServiceAccounts, to name a few.

Let's help Hero do some soul-searching and define every teensy aspect of their identity! What tool is best for the job?

## Choice 1: Helm

[Helm](https://helm.sh/) is a package manager for Kubernetes. With Helm, you can encapsulate all necessary Kubernetes resources into one atomic unit. This enables folks to be able to share applications with one another, and to more easily install and run a Kubernetes application from a trusted third party.

When using Helm to define the configuration of your own application, you can add dynamic abilities and parameterization. 

Additionally, Helm is a more mature technology that has an incredible ecosystem, and it works well alongside other Kubernetes configuration definition technologies, such as Kustomize and Kubernetes Operators.  

[![You're at the Helm](https://img.youtube.com/vi/oPIiX6vyih8/0.jpg)](https://youtu.be/oPIiX6vyih8)
* [Official site](https://helm.sh)

## Choice 2: Kustomize

Kustomize lets you customize raw, template-free YAML files for multiple purposes, leaving the original YAML untouched and usable as-is. In this way, Kustomize exposes and teaches native Kubernetes APIs, rather than hiding them.

Kustomize traverses Kubernetes definition files, and can add, update, or remove configuration options without forking. For example, you can define a *base* Kubernetes deployment that includes all organization-wide defaults. Then you can create a *patch* that references the base deployment but specifies values that are unique to your production environment, and then create another patch that references that same base file but defines the values that are unique to staging. Then, if an organization-wide value changes, that only needs to be updated in your configuration file one time, in the base yaml, and that change will propagate to your production and staging environment definitions.

This declarative approach to configuration customization has the added benefit of being natively built into *kubectl* with the `apply -k` commmand.  

[![Kustomize - How to Simplify Kubernetes Configuration Management](https://img.youtube.com/vi/Twtbg6LFnAg/0.jpg)](https://youtu.be/Twtbg6LFnAg)
[![Kustomize Demystified](https://img.youtube.com/vi/ZI7rsQ2LLHs/0.jpg)](https://youtu.be/ZI7rsQ2LLHs)
* [Official site](https://kustomize.io)

## Choice 3: Carvel ytt

`ytt` is a tool for YAML shaping that is part of the open source [Carvel](https://carvel.dev/) suite. With `ytt` you can template and overlay Kubernetes configuration via YAML structures, not text documents. This is because `ytt` understands YAML on a structural level which eliminates the need to count spaces, or for manual escaping.

With `ytt`, you can:
* **add programming logic to your YAML** - for example, you can externalize values to variables, extract repeated snippets to functions, and make whole sections conditional. `ytt` does this using a Python-like language called Starlark. 

* **patch YAML files** - this means you can use 'overlay' YAML files to modify base YAML files. With patching, you can do things like matching, inserting, replacing, or removing items.

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
[![What is cdk8s?](https://img.youtube.com/vi/GCZgLmksJW8/0.jpg)](https://youtu.be/GCZgLmksJW8)
* [Official site](https://cdk8s.io)

## Choice 5: KCL

TODO:

## What Is Your Choice?

* [Helm](helm.md)
* [Kustomize](kustomize.md)
* [Carvel ytt](carvel-ytt.md)
* [CDK For Kubernetes (cdk8s)](cdk8s.md)
* **KCL** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **kpt** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
