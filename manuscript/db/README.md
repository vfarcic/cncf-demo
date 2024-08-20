# Set Up PostgreSQL DB in the Dev Environment

Our Hero application has done it! They're running in a development environment! End of chapter, goal achieved! But wait. As time goes on Hero is feeling... bloated. There is so much to remember, and keeping track of all that data is really weighing them down.  They should be light and portable, and ready to evolve and scale at a moment's notice!

Hero needs persistent storage, and there is no need to reinvent the wheel here, so Hero knows they want to implement a third-party database (PostgreSQL) to store application state and user data. However, this decision isn't as straightforward as it may seem. Should the database run on a dedicated server in the cloud, completely outside of Kubernetes? Or should it run within the cluster? If we run it as a Kubernetes service, which technology should we use to define and manage this third-party application? Should it be mature, tried-and-true `Helm`, or does the new-kid-on-the-block technology `Crossplane` have something to offer?

Another thing to note here is that this database is a dependency of our Hero application. They're one-to-one, meaning that the database is meant to be used by Hero only. For that reason, Hero should define the database alongside their own deployment configuration.

Time to help Hero choose the best strategy for deploying and managing third-party applications!

[![Setup PostgreSQL DB In The Dev Environment - Feat. Helm And Crossplane (You Choose!, Ch. 1, Ep. 5)](https://img.youtube.com/vi/ITBPHJBbjPY/0.jpg)](https://youtu.be/ITBPHJBbjPY)

## Choice 1: Helm Chart

Helm is a package manager for Kubernetes, and it is currently the dominant way that third-party apps are installed into Kubernetes clusters. Helm is a mature technology with a thriving ecosystem. If our application itself is defined using Helm, adding PostgreSQL as an application dependency is a relatively easy process consisting of just a few Helm CLI commands. 

Once the PostgreSQL dependency is defined using Helm and included as part of the application manifest, the most common way to include app-specific configuration is to modify the values.yaml file that is packaged up within the PostgreSQL Helm chart. An example of app-specific configuration might be, say, including a reference to a Kubernetes Secret that the application will need in order to connect to the new PostgreSQL database.

Helm manages the application lifecycle with webhooks that are commonly implemented as Kubernetes Jobs. Some common use cases for this include waiting for dependencies to be installed, database upgrades during chart upgrades, and rollbacks upon failures.

With Helm, the person configuring the third-party application has access to manipulate any value that is referenced in the PostgreSQL Helm chart's values.yaml file, and if they really wanted to they could manipulate the Helm templates that are defined in the Helm chart too. This could be a good thing if that person is a specialist in ops/infrastructure and needs granular control in order to satisfy requirements that are unique to their particular system. Having access to all of the configurational complexity could also be not-so-good if a developer is the one doing the installation. If the developer has to understand the bigger system in order to make the changes that they need, this is likely an unnecessarily large cognitive load.

If you choose this option, the PosgreSQL database will be incorporated into our existing app configuration (defined using either Helm, Kustomize, Carvel YTT, or cdk8s) using Helm only. This updated configuration will then be applied to the cluster, deploying both our application and the database. 

[![You're at the Helm](https://img.youtube.com/vi/oPIiX6vyih8/0.jpg)](https://youtu.be/oPIiX6vyih8)
* [Official site](https://bitnami.com/stack/postgresql/helm)

## Choice 2: Crossplane Composition in Kubernetes

In our use case, a member of an application team (subsequently called an 'app friend') is likely to be the one who is tasked to deploy the application to the development environment, add the database, and connect the application to the new database. Does every app friend at the company who wants to develop/test a Kubernetes application that is connected to a database have to learn this entire process, plus the company's best practices around consuming infrastructure? What if they want to use a different type of database? What if the application they're working on has different sizing requirements? What if they're just busy elsewhere, doing more meaningful work?

With Crossplane, the humans in charge of infrastructurey stuff (subsequently referred to as 'ops folks') can configure all of the complex knowledge needed to install PostgresSQL into the cluster, create a database, and connect the application to that database, and then wrap that configuration up into a single Crossplane resource definition called a CompositeResourceDefinition (XRD).

This is an improvement for sure. It is helpful that all of the steps involved in creating and connecting to a database are automated and consolidated into a single resource. And it is also good that company-wide best practices can be suggested here. But to be honest, this Crossplane CompositeResource still seems like a beast of a thing. The humans who interact with it have to understand a lot about infrastructure, and it would be ideal for app friends to be able to get what they need without having to consider the complexities. 

But wait! They can! With Crossplane Compositions*, the ops folks can create a simplified interface that exposes only the aspects of the CompositeResource that the app friends care about. In our use case, this simplified interface (informally called a *claim*) might give an app friend the ability to create a claim resource that is only 10-20 lines of yaml where an app friend can specify the name of their database, which version of the database they'd like (or use a default), and whether they want their database to be small, medium, or large. And that's it! The app friend can define what they want and apply the claim to the cluster (or, better yet, push it to a git repo where GitOps magic happens), and then that person can blissfully go about doing their meaningful work while the infrastructurey stuff that they need gets created.

If you choose this option (using Crossplane Compositions to deploy and manage PostgreSQL resources in Kubernetes) we will configure Crossplane to install PostgreSQL still using Helm. There are two added benefits that Crossplane provides over plain Helm in this use case. One is that Crossplane can automate the whole setup process - no need to manually change the app configuration to mount the secret that contains the database connection details. The second benefit is that we as ops folks can provide a simplified interface for our app friends to be able to easily create and manage this infrastructure on their own.


[![Crossplane - GitOps-based Infrastructure as Code through Kubernetes API](https://img.youtube.com/vi/n8KjVmuHm7A/0.jpg)](https://youtu.be/n8KjVmuHm7A)
[![How To Shift Left Infrastructure Management Using Crossplane Compositions](https://img.youtube.com/vi/AtbS1u2j7po/0.jpg)](https://youtu.be/AtbS1u2j7po)
[![Crossplane: Control Plane of Control Planes](https://img.youtube.com/vi/CHBA34a0KEQ/0.jpg)](https://youtu.be/CHBA34a0KEQ)
* [Official site](https://crossplane.io)

## Choice 3: Crossplane Composition in Cloud

We just discussed using Crossplane Compositions to deploy PostgreSQL resources in Kubernetes, where all of the resources we're concerned with are created and managed within our Kubernetes cluster. But what if our app friend needs a database that is offered by a cloud provider? What if they need a PostgreSQL server that is provisioned completely outside of Kubernetes? An organization might choose to run a cloud database in development to replicate a bug that is happening in production, or perhaps they're just fancy like that.

It is time to highlight another cool feature of Crossplane -  that it is capable of creating and managing infrastructure that is running completely outside of a Kubernetes cluster.  Crossplane has this concept called a *provider*. A provider extends Crossplane and provides custom Kubernetes controllers for new kinds of managed resources. There are [many available providers](https://marketplace.upbound.io/providers), like the AWS provider, the GCP provider, and the Azure provider. For example, the AWS provider extends Crossplane so that it supports AWS-managed resources like RDSInstances and S3Buckets. That means that if you install the Crossplane AWS provider you not only can use Crossplane and Kubernetes to provision AWS resources, but you can additionally use Crossplane's custom Kubernetes controllers to watch the state of those resources to make sure the actual state of your AWS infrastructure is always in sync with the state that you've defined using Crossplane. 

So, just like before, the ops folks can configure all of the complex knowledge needed to create a PostgresSQL server, create a database instance, and connect the application to that database, and then wrap it up into a Crossplane CompositeResourceDefinition. But this time the PostgreSQL instance is a standalone server that is offered by a cloud provider rather than a third-party application running in Kubernetes.

And, just like before, the ops folks can use Crossplane Compositions* to create a simplified interface that exposes only the aspects of the CompositeResource that the app friends care about. Again, this simplified resource might give an app friend the ability to create a claim resource (only 10-20 lines of yaml) where an app friend can specify the name of their database, which version of the database they'd like, and whether they want their database to be small, medium, or large... but this time, with a cloud-based PostgreSQL instance, the custom claim resource might also offer an option to the app friend asking which cloud provider they'd like to use for their PostgreSQL server.

And that's it!  The app friend doesn't need to interact with the cloud provider directly, nor do they need to open a ticket and wait.  And ops folks don't need to waste their valuable time and expertise manually creating cloud resources for app friends. In that way, Crossplane Compositions* can be helpful in creating a clear separation of concerns between ops folks and app friends, allowing each group to utilize the expertise that they have in their own areas, and maximizing each group's meaningful work. Who isn't extremely glad to avoid toil, distraction, and duplication of effort?

If you choose this option (using Crossplane Compositions to deploy and manage PostgreSQL resources in the cloud), we will configure Crossplane to install a PostgreSQL server running in your favorite cloud. Just as before, Crossplane can automate the whole setup process, and ops folks can provide a simplified interface for our app friends to be able to easily create and manage this infrastructure on their own. This choice has the added benefit of managing resources that are completely outside of Kubernetes. And... spoiler alert! This strategy also sets us up to use [GitOps principles](https://opengitops.dev/#principles) later on down the line. 

[![Crossplane - GitOps-based Infrastructure as Code through Kubernetes API](https://img.youtube.com/vi/n8KjVmuHm7A/0.jpg)](https://youtu.be/n8KjVmuHm7A)
[![How To Shift Left Infrastructure Management Using Crossplane Compositions](https://img.youtube.com/vi/AtbS1u2j7po/0.jpg)](https://youtu.be/AtbS1u2j7po)
[![Crossplane: Control Plane of Control Planes](https://img.youtube.com/vi/CHBA34a0KEQ/0.jpg)](https://youtu.be/CHBA34a0KEQ)
* [Official site](https://crossplane.io)


*Here the term *Composition* refers broadly to the feature of Crossplane that allows ops folks to define their own opinionated platform APIs and expose simplified interfaces to app friends. However, in Crossplane a `Composition` can also refer to the specific Crossplane custom resource that connects Crossplane to each of the wide variety of possible resources that ultimately make up a higher-level CompositeResource. Don't worry if you don't understand this part yet. The point here is simply that the terminology is confusing.

## What Is Your Choice?

* [Helm Chart](helm.md)
* [Crossplane Composition In Kubernetes](crossplane-local.md)
* [Crossplane Composition In Cloud](crossplane-cloud.md)
