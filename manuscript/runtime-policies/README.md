# Runtime Policies

Now that admission policies have been added, the production cluster where Hero lives is much more secure and efficient. But although Hero and Lil DeeBee feel safer, they still can’t settle down. They can’t shake the feeling that there are unseen threats that lurk in the shadows.

Applications running here each have their own supporting services and dependencies, which in turn each have their own supporting services and dependencies, which each may have their own too. And on and on. Additionally, many of these applications, supporting services, and dependencies are third-party, and each is responsible for its own security. Does Hero completely trust another company’s security practices? Have they properly scanned for CVEs? What if the software contains CVEs that are not yet known? With everything building on top of everything else, it is perhaps impossible to know the origin and contents of each and every bit of code that will run in the cluster. How can Hero have peace of mind? What will help Lil DeeBee sleep at night?

The answer: Runtime policies! Runtime policies help to protect Hero, Lil DeeBee, and their neighbors from security vulnerabilities and threats during their execution. These policies help to secure against unknown unknowns at runtime. But all of the applications in the cluster each have so many processes running! As the estate grows there might be hundreds of thousands or even millions of processes running at once! How can a runtime security tool even begin to monitor them all?

With runtime security, monitoring is done at the kernel level of each host machine. That means that runtime security is not application-specific. A runtime security tool will look at kernel-level events such as a process being executed, a file being opened, something being accessed over the network, or a particular system call being made.

When one is implementing runtime policy, the first step is to monitor these kernel-level events to define expected behavior in the system. Then one can create a policy that will do something when an unexpected event occurs. What that something is depends on the tool—so let’s learn about CNCF tools that help to define and enforce runtime policy!

## Choice 1: KubeArmor

KubeArmor is a cloud native runtime security engine that helps you monitor your system at the kernel level, alert on anomalies, and prevent security issues. 

By the time you see an alert, an attack may have already happened—that’s worrisome. What’s cool about KubeArmor is that it facilitates inline enforcement, meaning that when an attack is attempted, it fails. The prevention happens alongside the alert. KubeArmor uses Linux Security Modules (LSMs) to achieve this. 

KubeArmor is performant because it directly hooks inside the Linux kernel using eBPF. That is where (and how) it safely monitors runtime events and enforces runtime policies. 

Finally, KubeArmor can supply recommended policies that are based on industry standards. 


[![Armoring up Your Workloads with KubeArmor](https://img.youtube.com/vi/fHSw-CuYgoY/0.jpg)](https://youtu.be/fHSw-CuYgoY)
* [Official site](https://kubearmor.io)

## Choice 2: Falco

Falco is a cloud native threat detector. 

In Falco, a *threat* is an event that could endanger the system. Falco can monitor events (and therefore detect threats) from many sources. These sources fall under two umbrellas: kernel events (either from Falco's kernel module or eBPF probe) and plugin events (like Kubernetes audit events, Okta events, and [more](https://github.com/falcosecurity/plugins/blob/master/registry.yaml)). Falco processes these events in real time and if one violates a Falco Rule, it triggers an alert. 

A Falco Rule is a YAML file that defines the conditions under which an alert should be generated. You can make your own of course, but there are also about 70 Falco Rules that the Falco community has created and maintains. 

Falco alerts can be forwarded to 50+ compatible destinations, such as Slack or Telegram. Falco also has a sub-project called Falco Talon which can take action on alerts. For example, when an alert happens then kill a container, or when a different alert happens then start collecting additional information.


[![Detecting Kubernetes Security Threats with Falco](https://img.youtube.com/vi/0tBSKRvH3xo/0.jpg)](https://youtu.be/0tBSKRvH3xo)
[![Playing "Guess Who?" – Detecting Threats With Falco](https://img.youtube.com/vi/ojcMrXiid-I/0.jpg)](https://youtu.be/ojcMrXiid-I)
* [Official site](https://falco.org)

## What Is Your Choice?

* [KubeArmor](kubearmor.md)
* [Falco](falco.md)
