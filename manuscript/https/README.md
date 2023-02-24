# Use HTTPS

Hero is now configured and running in a development environment! Hero should be beaming with pride, but instead Hero is feeling…insecure.

Like many of us, Hero has trust issues! How can Hero ensure that the users of their application don’t intend to cause harm to them or to the system? How can Hero’s users trust that Hero won’t harm them? To pass this stage of the journey, Hero needs to learn how to exchange secure communications with each end user.

### What is HTTPS?

Hyper Text Transfer Protocol (HTTP) is a protocol by which two computers communicate with one another. Usually the two computers in question are a web server (where Hero is currently) and a web browser (where user requests originate). HTTP**S** is the secure version of HTTP.

### What does it take to secure HTTP?

HTTP becomes HTTP**S** when it uses Transport Layer Security (TLS) protocol to authenticate and encrypt the HTTP communication that is traveling between the application’s web server and the end user’s web browser.

In order for TLS* to work, the two communicating entities establish trust by exchanging and validating each other’s X.509 certificates.* Each X.509 certificate contains a public key that is used to encrypt communication. Private keys are used to decrypt incoming messages that were encrypted with the corresponding public key. Private keys are additionally used to sign outgoing messages so that the entity that receives the message can trust that it is from the private key owner.  

Wow. That’s a lot. Right now all Hero needs to know is that they need to use *certificates* so that they can trust incoming traffic, and so that incoming traffic can trust Hero.  Let’s look at some tools that help Hero build trust. 


*TLS can also be called SSL, which stands for Secure Sockets Layer

*X.509 certificates can also be called *digital certificates*, *Private Key Infrastructure (PKI) certificates*, or often just *certificates*

**If you chose to use `nip.io` instead of a "real" domain name, you should skip this chapter by jumping directly to [Setup PostgreSQL DB](../db/README.md).**

## Choice 1: HashiCorp Vault

TODO: Explanation

* [Official site](https://vaultproject.io/)

## Choice 2: cert-manager

TODO: Explanation

[![What Is HTTPS? How Does It Work? Automate With cert-manager And Let's Encrypt](https://img.youtube.com/vi/D7ijCjE31GA/0.jpg)](https://youtu.be/D7ijCjE31GA)
[![De-stress Certificates with cert-manager!](https://img.youtube.com/vi/DthwYI46DYo/0.jpg)](https://via.vmw.com/cert-manager)
* [Official site](https://cert-manager.io/)

## What Is Your Choice?

* [HashiCorp Vault](vault.md)
* [cert-manager](cert-manager.md)