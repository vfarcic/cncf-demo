# Set Up PostgreSQL DB in the Dev Environment

Our Hero application has done it! They’re running in a development environment! End of chapter, goal achieved! But wait. As time goes on Hero is feeling… bloated. There is so much to remember, and keeping track of all that data is really weighing them down.  They should be light and portable, and ready to evolve and scale at a moment’s notice!

Hero needs persistent storage, and there is no need to reinvent the wheel here, so Hero knows they want to implement a third-party database (PostgreSQL) to store application state and user data. However, this decision isn’t as straightforward as it may seem. Should the database run on a dedicated server in the cloud, completely outside of Kubernetes? Or should it run within the cluster? If we run it as a Kubernetes service, which technology should we use to define and manage this third-party application? Should it be mature, tried-and-true `Helm`, or does the new-kid-on-the-block technology `Crossplane` have something to offer?

Time to help Hero choose the best strategy for deploying and managing third-party applications!

## Choice 1: Helm Chart

TODO: Explanation

[![You're at the Helm](https://img.youtube.com/vi/oPIiX6vyih8/0.jpg)](https://via.vmw.com/Helm)
* [Official site](https://bitnami.com/stack/postgresql/helm)

## Choice 2: Crossplane Composition In Kubernetes

TODO: Explanation

[![Crossplane - GitOps-based Infrastructure as Code through Kubernetes API](https://img.youtube.com/vi/n8KjVmuHm7A/0.jpg)](https://youtu.be/n8KjVmuHm7A)
[![How To Shift Left Infrastructure Management Using Crossplane Compositions](https://img.youtube.com/vi/AtbS1u2j7po/0.jpg)](https://youtu.be/AtbS1u2j7po)
[![Crossplane: Control Plane of Control Planes](https://img.youtube.com/vi/CHBA34a0KEQ/0.jpg)](https://via.vmw.com/Crossplane)
* [Official site](https://crossplane.io)

## Choice 3: Crossplane Composition In Cloud

TODO: Explanation

[![Crossplane - GitOps-based Infrastructure as Code through Kubernetes API](https://img.youtube.com/vi/n8KjVmuHm7A/0.jpg)](https://youtu.be/n8KjVmuHm7A)
[![How To Shift Left Infrastructure Management Using Crossplane Compositions](https://img.youtube.com/vi/AtbS1u2j7po/0.jpg)](https://youtu.be/AtbS1u2j7po)
[![Crossplane: Control Plane of Control Planes](https://img.youtube.com/vi/CHBA34a0KEQ/0.jpg)](https://via.vmw.com/Crossplane)
* [Official site](https://crossplane.io)

## What Is Your Choice?

* [Helm Chart](helm.md)
* [Crossplane Composition In Kubernetes](crossplane-local.md)
* [Crossplane Composition In Cloud](crossplane-cloud.md)
