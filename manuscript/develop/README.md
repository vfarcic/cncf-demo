# Develop the Application

Together our application (Hero) and database sidekick (Lil DeeBee) are one hundred percent, absolutely ready to run in a development environment! Finally! The first quest in the long journey to production is complete!

But wait, 'running in a development environment' isn't a static situation. The whole point of a development environment is to have a safe place where Hero and Lil DeeBee can change and grow without end users being affected.

When a developer makes a change to Hero's source code, in order to see that change, does the developer have to go through the entire process of building an image, embedding the container image reference into the application configuration, and redeploying our hero application? That is a lot of effort, and it is not a valuable use of the developer's time. There should be a way for the developer to make changes and get fast feedback, and for them to be able to easily interact with the other applications, third-party services, and tools that are also running in development.

Hero is also wondering whether it is a good idea for a development environment to be running all of the time. What is the point of them running day and night if they are not being actively accessed and/or developed? 

AND another question! What development solutions enable developers to remotely collaborate while working on the application? What does that look like?

Let's help Hero choose which tool to use to help application teams quickly and effectively develop their container-based applications.

[![Develop Apps - Feat. Telepresence, DevSpace, Nocalhost, And Devfile (You Choose!, Ch. 1, Ep. 7)](https://img.youtube.com/vi/YqmLIh31VH0/0.jpg)](https://youtu.be/YqmLIh31VH0)

## Choice 1: Telepresence

Telepresence is a remote-to-local fast feedback development tool for Kubernetes. With Telepresence, application teams can develop locally against a remote Kubernetes cluster. Developers (and stakeholders!) can see the changes they make to their Kubernetes application without building/pushing/running container images. They can also see how their application behaves in their Kubernetes environment, meaning that they can interact with all of the other Kubernetes services that are running in their development cluster. Additionally, developers can use their own local IDEs and tooling, as well as access preview urls so that they can see and share their app's behavior.

Telepresence works by intercepting traffic that is intended for the application running in the remote Kubernetes cluster, and redirecting that traffic to the copy of that application that is running on the developer's laptop. 

[![Remocal K8s Development FTW: Telepresence 101](https://img.youtube.com/vi/VLABvVtUZvk/0.jpg)](https://youtu.be/VLABvVtUZvk)
* [Official site](https://www.telepresence.io)

## Choice 2: DevSpace

With DevSpace, you declare the entire state of the development environment (or any other environment) DECLARATIVELY and DevSpace does the work of bringing that state into being. This can work with a fresh cluster that might get made every time a development session begins, or a DevSpace file can be applied against an already-existing cluster, in which case DevSpace will create and/or modify the defined resources so that the actual state is in sync with the state that is defined in DevSpace. This declarative model can help users create a standardized, well-defined workflow across teams, as well as facilitate quick onboarding.

DevSpace improves the developer experience by enabling a fast development cycle that makes Kubernetes invisible to the developer. This is made possible by a file sync mechanism (aka 'hot reloading') where the app source code gets mounted directly into the container that is running in the Kubernetes development environment. That way, when a developer saves an application change, the change is automatically reflected in the Kubernetes development environment. 

[![DevSpace - Development Environments in Kubernetes](https://img.youtube.com/vi/nQly_CEjJc4/0.jpg)](https://youtu.be/nQly_CEjJc4)
[![Full App Lifecycle In Kubernetes With Argo CD, DevSpace, vCluster, k3d, and GitHub Actions](https://img.youtube.com/vi/uU-EAQ8Vbvk/0.jpg)](https://youtu.be/uU-EAQ8Vbvk)
[![Develop at Lightning Speed on Kubernetes with DevSpace](https://img.youtube.com/vi/T_NYcuqUCF0/0.jpg)](https://youtu.be/T_NYcuqUCF0)
* [Official site](https://devspace.sh)

## Choice 3: Nocalhost

Nocalhost is an open-source IDE plugin for cloud-native applications development.

* [Official site](https://nocalhost.dev)

## Choice 4: Devfile With odo

Devfile is a specification that allows users to declaratively include the development environment information as part of their application. Devfiles can be used to automate and simplify the development process. This can be done by adopting existing devfiles that are available in the public community registry, or by authoring your own devfiles to record custom instructions for how to configure and run your development environment.

To use devfiles, you'll need a tool that understands them. Tools that provide devfile support include odo, Eclipse Che, VSCode OpenShift Toolkit, Amazon CodeCatalyst, JetBrains Space, OpenShift Dev Console, and IntelliJ OpenShift Toolkit.

[![Software Defined Cloud Dev Environments with the Devfile](https://img.youtube.com/vi/65qbpPW38xs/0.jpg)](https://youtu.be/65qbpPW38xs)
* [Official Devfile site](https://devfile.io)
* [Official odo site](https://odo.dev)


## What Is Your Choice?

* [Telepresence](telepresence.md)
* [DevSpace](devspace.md)
* [Nocalhost](nocalhost.md)
* **Devfile with odo** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.