# Use HTTPS

**If you chose to use `nip.io` instead of a "real" domain name, you should skip this chapter by jumping directly to [Setup PostgreSQL DB](../db/README.md).**

</br>

Hero is now configured and running in a development environment! Hero should be beaming with pride, but instead Hero is feeling...insecure.

Like many of us, Hero has trust issues! How can Hero ensure that the users of their application don't intend to cause harm to them or to the system? How can Hero's users trust that Hero won't harm them? To pass this stage of the journey, Hero needs to learn how to exchange secure communications with each end user.

[![Use HTTPS - Feat. cert-manager (You Choose!, Ch. 1, Ep. 4)](https://img.youtube.com/vi/sSbe6qedElE/0.jpg)](https://youtu.be/sSbe6qedElE)

### What is HTTPS?

Hyper Text Transfer Protocol (HTTP) is a protocol by which two computers communicate with one another. Usually the two computers in question are a web server (where Hero is currently) and a web browser (where user requests originate). HTTP**S** is the secure version of HTTP.

### What does it take to secure HTTP?

HTTP becomes HTTP**S** when it uses Transport Layer Security (TLS) protocol to authenticate and encrypt the HTTP communication that is traveling between the application's web server and the end user's web browser.

In order for TLS* to work, the two communicating entities establish trust by exchanging and validating each other's X.509 certificates.* Each X.509 certificate contains a public key that is used to encrypt communication. Private keys are used to decrypt incoming messages that were encrypted with the corresponding public key. Private keys are additionally used to sign outgoing messages so that the entity that receives the message can trust that it is from the private key owner.  

Wow. That's a lot. Right now all Hero needs to know is that they need to use *certificates* so that they can trust incoming traffic, and so that incoming traffic can trust Hero.  Let's look at some tools that help Hero build trust. 

</br>

*TLS can also be called SSL, which stands for Secure Sockets Layer

*X.509 certificates can also be called *digital certificates*, *Private Key Infrastructure (PKI) certificates*, or often just *certificates*

## Choice 1: cert-manager

cert-manager aims to be (and quite possibly is) the easiest way to automate certificate management in Kubernetes.  Once a cluster admin has installed and configured the proper cert-manager custom Kubernetes resources, the user experience is as follows:

1 - specify what you need (“I need a certificate for example.com...”)

2 - specify how to get it by referencing an `Issuer`* that was set up by a cluster admin (“...from this particular Certificate Authority (CA)...”)

3 - specify the Kubernetes Secret where you want to store the resulting certificate (“...and I want it to be stored in this Secret”)

And that's it! The certificate gets created and stored in the referenced Secret! The user specifies those three things (and more if they like, for example, the duration in which they want the certificate to be valid) and then cert-manager handles generating the private key, creating the Certificate Signing Request (CSR), and submitting the CSR to the CA. Then, assuming all goes well, cert-manager will take the brand-new certificate (and entire certificate chain) that the CA returned and put it in the Kubernetes Secret that the user specified.  cert-manager will also automatically renew the certificate before it expires! Booya!

So from a user perspective, all you do is create a `Certificate` resource where you specify what you want “I need a certificate for example.com via this particular `Issuer` (from this particular CA) and I want it to be stored in a Secret called example-com-tls” and then the certificate appears in the specified Secret! cert-manager will then ensure the certificate is valid, ensure that it is up-to-date, and will attempt to renew the certificate at a configured time before expiry.


*An `Issuer` is another cert-manager custom Kubernetes resource. It tells cert-manager how to connect to a particular CA. cert-manager will obtain certificates from a variety of Issuers, both popular public Issuers as well as private Issuers.

[![What Is HTTPS? How Does It Work? Automate With cert-manager And Let's Encrypt](https://img.youtube.com/vi/D7ijCjE31GA/0.jpg)](https://youtu.be/D7ijCjE31GA)
[![De-stress Certificates with cert-manager!](https://img.youtube.com/vi/DthwYI46DYo/0.jpg)](https://youtu.be/DthwYI46DYo)
* [Official site](https://cert-manager.io/)

## What Is Your Choice?

* [cert-manager](cert-manager.md)