# Develop The Application

Together our application (Hero) and database sidekick (Lil DeeBee) are one hundred percent, absolutely ready to run in a development environment! Finally! The first quest in the long journey to production is complete!

But wait, ‘running in a development environment’ isn’t a static situation. The whole point of a development environment is to have a safe place where Hero and Lil DeeBee can change and grow without end users being affected.

When a developer makes a change to Hero’s source code, in order to see that change, does the developer have to go through the entire process of building an image, embedding the container image reference into the application configuration, and redeploying our hero application? That is a lot of effort, and it is not a valuable use of the developer’s time. There should be a way for the developer to make changes and get fast feedback, and for them to be able to easily interact with the other applications, third-party services, and tools that are also running in development.

Hero is also wondering whether it is a good idea for a development environment to be running all of the time. What is the point of them running day and night if they are not being actively accessed and/or developed? 

AND another question! What development solutions enable developers to remotely collaborate while working on the application? What does that look like?

Let’s help Hero choose which tool to use to help application teams quickly and effectively develop their container-based applications.

## Choice 1: Telepresence

TODO: Explanation

[![Remocal K8s Development FTW: Telepresence 101](https://img.youtube.com/vi/VLABvVtUZvk/0.jpg)](https://via.vmw.com/Telepresence)
* [Official site](https://www.telepresence.io)

## Choice 2: DevSpace

TODO: Explanation

[![DevSpace - Development Environments in Kubernetes](https://img.youtube.com/vi/nQly_CEjJc4/0.jpg)](https://youtu.be/nQly_CEjJc4)
[![Full App Lifecycle In Kubernetes With Argo CD, DevSpace, vCluster, k3d, and GitHub Actions](https://img.youtube.com/vi/uU-EAQ8Vbvk/0.jpg)](https://youtu.be/uU-EAQ8Vbvk)
[![Develop at Lightning Speed on Kubernetes with DevSpace](https://img.youtube.com/vi/T_NYcuqUCF0/0.jpg)](https://via.vmw.com/DevSpace)
* [Official site](https://devspace.sh)

## Choice 3: Nocalhost

TODO: Explanation

* [Official site](https://nocalhost.dev)

## Choice 4: Devfile

TODO: Explanation

* [Official site](https://devfile.io)

## What Is Your Choice?

* [Telepresence](telepresence.md)
* [DevSpace](devspace.md)
* [Nocalhost](nocalhost.md)
* [Devfile](devfile.md)