# Kubernetes Dashboards

Hero is feeling FANTABULOUS! They’ve done so much to secure the cluster! But now Hero has a whole new problem: Hero has no idea what is going on. Hero doesn’t have a good understanding of their own application internals, Hero doesn’t get how they relate to the applications who are sharing the cluster with them, and Hero doesn’t know what’s happening on an infrastructure level either. Oh! And what just went wrong?! How can it be fixed!? Hero is desperate to escape this fog by adding CNCF tools for observability!

Hero has decided to start by adding a Kubernetes Dashboard tool. At the very least, this tool will provide a visual representation of how Kubernetes system components relate to one another, and it will provide a user interface (UI) for manipulating Kubernetes entities. 

A visual cluster view has many advantages! Kubernetes visualization can do the following:
* Help users understand how Kubernetes components relate to one another
* Help users navigate the cluster to find and fix problems
* Provide high-level information all at once (a picture is worth 1000 words!)
* Make Kubernetes more accessible to less skilled users

Hero sees the irony in using lots of words to describe visualization. Let’s hurry up and choose a tool so that we can see the pretty dashboard colors already!


## Choice 1: Meshery

Meshery is a self-service, extensible engineering platform for Kubernetes. It is management software, like a control plane for control planes. It has a collaborative interface for viewing, manipulating, and integrating a large number of underlying cloud and cloud native systems–it isn’t limited to just Kubernetes.

Meshery is excellent for:
* experimenting with the functionality of new tools
* experimenting with tool integration
* experimenting with the performance of different configurations
* communication between people and teams = “GraphOps”
* facilitating collaboration in production

[![Infrastructure by Design with Meshery](https://img.youtube.com/vi/DfTvlSwE8R4/0.jpg)](https://youtu.be/DfTvlSwE8R4)
* [Official site](https://meshery.io)

## Choice 2: Kubernetes Dashboard

Kubernetes Dashboard is a UI and visual representation of the Kubernetes APIs. Kubernetes Dashboard is a straightforward tool that provides visualization directly for kube-api. It can only visualize one cluster at a time.

[![Make Your Life Easier with the Kubernetes Dashboard](https://img.youtube.com/vi/Dz0ZAQkpOHg/0.jpg)](https://youtu.be/Dz0ZAQkpOHg)
* [Official site](https://github.com/kubernetes/dashboard)

## Choice 3: Headlamp

Headlamp is a GUI for Kubernetes that aspires to give you the best user experience while building on top of a shared and extensible platform. Out-of-the-box, Headlamp provides cluster-focused information and visualization, but it can be extended to additionally provide application-specific visuals and functionality. 

[Examples of Headlamp plugins](https://headlamp.dev/docs/latest/development/plugins/functionality) include one to help you add a custom sidebar item, one to collect and display Prometheus metrics, and a plugin that displays your company's logo. 

Headlamp has an adaptable UI. This means that Headlamp tries to understand and expose exactly what the user can do, nothing less and nothing more. F​​or example, no “edit” button will appear if the user doesn’t have permission to edit a resource.

Headlamp is available as both a desktop and web application.


[![Make Your Own Kubernetes User Experience with Headlamp!](https://img.youtube.com/vi/hR-koOUsaMA/0.jpg)](https://youtu.be/hR-koOUsaMA)
* [Official site](https://headlamp.dev)

## What Is Your Choice?

* **Meshery** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* **Kubernetes Dashboard** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* [Headlamp](headlamp.md)
