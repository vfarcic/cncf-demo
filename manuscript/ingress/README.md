# Implementing Ingress

There is a directory here on the management cluster that is being watched by a GitOps tool! Hero knows that as soon as they and Lil DeeBee step foot inside that magical directory, the GitOps tool will deploy them into production! Wheeeeee! Hero is so JAZZED!

But wait, there is one more thing that needs to happen to prepare the production environment for Hero's arrival: we need to get end-user traffic from outside of our production cluster to inside the cluster. We need to implement Ingress. INGRESS.

The air leaves Hero's sails. INGRESS. Hero slumps into a chair, defeated. INGRESS. Ingress is quite an obstacle - it is especially difficult to learn and understand. Will Hero and Lil DeeBee ever get to serve end users? 
<br><br><br>
### Why is Ingress hard?
<br>
There are some barriers to entry when it comes to learning about Ingress:

Ingress is hard to understand- Reason #1: **Kubernetes doesn't have a native Ingress Controller.** Unlike other types of controllers for Kubernetes-native objects which run as part of the kube-controller-manager binary, controllers for Ingress objects are not started automatically with a cluster. If you have a fresh install of a cluster and you describe a desired state in an Ingress object and apply that Ingress object to the cluster, nothing happens! To solve this you need to install an Ingress Controller. Simply go to the [Kubernetes documentation for Ingress Controllers](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) and... WHAT?! There are 30 choices here! How on Earth is one meant to suss out which is best for their particular use case?

Ingress is hard to understand- Reason #2: **Ingress Controllers have other names too** - such as Ingress implementations, Ingress providers, Ingress services, L7, or, infuriatingly, just “Ingress”⎯which can easily be confused with the Ingress object itself. Also, in all but the most advanced use cases, an Ingress Controller can perform the functionality needed for an API Gateway. So Ingress Controller projects that have added that additional functionality might refer to themselves as API Gateways! And some service meshes (*cough, cough* **Kuma**) have expanded to be able to receive requests from outside of a cluster, essentially being able to perform the functionality of a lightweight Ingress controller. Ughhhhhh.

Ingress is hard to understand- Reason #3: **Ingress Controllers are usually powered by a network proxy** like Envoy, Cilium, HAProxy, NGINX, or Traefik, to name a few. These technologies do the complicated work of actually routing the requests, and different Ingress Controller implementations may choose to use the same underlying network proxy. Network proxies are often so complex that humans shouldn't interact with them directly, so the Ingress Controller implementations act as human-friendly interfaces to be able to configure the network proxies (“data layer”) to do fancy routing things such as weighted load balancing or header-based routing.

Ingress is hard to understand- Reason #4: **The native Kubernetes Ingress object isn't great.** There are three areas where the Ingress object has room for improvement:

* **The native Kubernetes Ingress object doesn't have enough functionality.** Folks need more control over how their traffic is routed in Kubernetes than what the Ingress object provides. For example, people might want to do something like weighted load balancing⎯perhaps they want to send disproportionately more traffic to an instance of a service that has more compute available. People also want to be able to do more advanced routing, like filter HTTP requests based on header information and perhaps redirect traffic based on the results. And much, much more!
* **The native Kubernetes Ingress object doesn't separate concerns** between ops folks (who care about traffic for the entire cluster) and app friends (who just want to get traffic to their application). There are permission problems, there are routing granularity problems... and for the love of all things good let's help app friends easily get traffic to their running applications!
* **The native Kubernetes Ingress object doesn't have status information.** The native Kubernetes Ingress object can't show you when something is wrong and therefore it is very hard to debug.


So, basically, all [30 Ingress controllers listed in the Kubernetes documentation](https://kubernetes.io/docs/concepts/services-networking/ingress-controllers/) have each come up with their own unique solutions for these shortcomings of the native Kubernetes Ingress object.

To solve this, **some Ingress controller projects have added additional functionality via annotations in the Kubernetes-native Ingress resource**. While this gets the job done, it isn't optimal because annotations are unstructured data, and it is complex to keep that data consistent. That, and adding functionality via annotations doesn't address the other two problems with the Kubernetes Ingress object - the problem of separating concerns between ops folks and app friends, and the fact that the Ingress object is difficult to debug. In fact, I'd say that adding functionality with annotations makes the Kubernetes Ingress object even more difficult to debug. Sigh.

**Other Ingress controller projects are making their own Custom Resource Definitions (CRDs) to supplement and/or completely replace the Kubernetes-native Ingress object.** These CRDs address some or all of the three Ingress object problems. The Custom Resource Definitions add functionality in the resource spec itself instead of adding functionality via annotations. Adding additional capabilities in the resource spec field means that the data can be declarative, structured, and validated⎯woo-hoo! The custom resources also include more status information, and at least some of them address the need to separate concerns between teams. 

Great! Problem solved! But still, a problem solved in 30 different ways is terribly difficult to understand and navigate. How can I begin to know what is the best choice for me? Also once I start using these project-specific CRDs in my cluster I will get locked into a particular Ingress Controller implementation. That's no good. What if my needs change over time? All of this Ingress stuff feels like a hot, steamy mess.
<br><br><br>
### Gateway API
<br>

**Gateway API is a specification that models service networking in Kubernetes.**

More specifically, **Gateway API is a set of Custom Resource Definitions that describe how traffic gets transported (and perhaps translated) from the outside of a Kubernetes cluster to the inside of a Kubernetes cluster.** So basically these Gateway API CRDs are objects that all Kubernetes-networking-related projects can use to get traffic from somewhere that doesn't know about Kubernetes to somewhere that does. Although Gateway API is not part of the core Kubernetes codebase, it is created and maintained by the Kubernetes' [SIG-Network](https://github.com/kubernetes/community/tree/master/sig-network) community.

And, again, Gateway API is a *specification* not an *implementation*. 

The Gateway API specification has four goals:

* **Gateway API should be expressive.** This means that the Gateway API custom resource definitions should be able to include more core functionality. Gateway API aims to improve the native Kubernetes Ingress object.
* **Gateway API should be extensible.** If people want additional functionality outside of what is offered in the Gateway API specification, there should be a standardized way to add it.
* **Gateway API should be portable.** Users should be able to move freely between different Kubernetes networking-related projects that implement Gateway API.
* **Gateway API should be role-oriented.** The Gateway API custom resources should address the needs of different personas. Ops folks should have full control of all traffic in the cluster, and app friends should have a simple way to easily get the right traffic through to their running application.

By now you should have a good understanding of why the Ingress landscape is difficult to navigate, and how the Gateway API specification helps in two ways: first, by defining what a model networking solution should look like, and second, by considering the perspectives of different personas.

Now, FINALLY, with all of this context, it is time to consider the three CNCF Ingress projects at hand! Which project do you choose to get end-user traffic into our production cluster and through to Hero, our running application? Let's cheer them up! Ingress isn't so bad, Hero... we got this!
<br><br>
[![What Is Gateway API?](https://img.youtube.com/vi/G_5tRFY6N_k/0.jpg)](https://youtu.be/G_5tRFY6N_k)

## Choice 1: ingress-nginx

ingress-nginx is a Kubernetes Ingress implementation that uses Ingress objects to maintain and configure nginx. ingress-nginx is maintained by the Kubernetes project.

ingress-nginx uses the native Kubernetes Ingress object and adds extra functionality via **modules**, of which there are about 30. Modules are added and configured via annotations to the Ingress object.

[![What Is ingress-nginx?](https://img.youtube.com/vi/ly_zzKR_alA/0.jpg)](https://youtu.be/ly_zzKR_alA)
* [Official site](https://kubernetes.github.io/ingress-nginx)

## Choice 2: Contour with Envoy

Contour is a Kubernetes Ingress Controller that uses Envoy as a load balaner and proxy, with additional features above and beyond the native Kubernetes Ingress object.

Specifically, Contour introduces a **HTTPProxy** CRD that does everything that a native Kubernetes Ingress object does but with more features:
* minimum annotations
* capabilities are added to the resources spec itself
* can separate concerns between teams
* adds detailed status info (is it valid? what are the errors?)
* provides statistics for Ops folks
* TLS cert delegation - a safe way to reference secrets in different namespaces

[![Implementing Ingress with Contour](https://img.youtube.com/vi/zFx7gdM7xpQ/0.jpg)](https://youtu.be/zFx7gdM7xpQ)
* [Official site](https://projectcontour.io)

## Choice 3: Emissary-ingress with Envoy

Emissary-ingress is a self-service, Kubernetes-native, API Gateway.

Emissary-ingress introduces many CRDs. Here are the 3 most important:
* **Mapping** - a mapping controls where we're sending traffic & whether we are changing anything about that traffic
* **Listener** - a listener configures what ports we lisen on & what protocol we are listening for. For example, port 8443 only listens for HTTPS
* **Host** - a host configures what hostname you want to support (can do wildcard). It also has support for TLS.

[![Self-Service Traffic Management with Emissary-ingress](https://img.youtube.com/vi/XT2NQ4IZwNo/0.jpg)](https://youtu.be/XT2NQ4IZwNo)
* [Official site](https://www.getambassador.io/products/api-gateway)

## What Is Your Choice?

* [ingress-nginx](nginx.md)
* [Envoy with Contour](contour.md)
* [Emissary-ingress](emissary-ingress.md)