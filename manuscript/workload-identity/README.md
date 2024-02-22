# Generating Workload Identity

Hero’s head is swirling with the complexity of all of this security stuff. Hero is taking inventory of all of the sensitive data they have to manage just to get around production: private keys, tokens, passwords, certificates… and Hero realizes, all of these secrets have to do with establishing the identity of their processes. Each service and system that Hero’s processes interact with first asks the question “What is the identity of the workload that is currently trying to connect to me?” Depending on the service or system that Hero is connecting to, to establish identity, Hero might need to present a certificate, or a token, or a password. It is a pain to store all of these secrets, a pain to keep them safe from hackers, a pain to keep them all rotated and current, and a pain to know which one to present to which system at which time.

Hero has been in tech long enough to know: when there are many different approaches to doing the same thing, it is best to have an industry-adopted specification. And look at that! There *is* a specification for generating and managing identities for workloads! SPIFFE!

## The Specification: SPIFFE

SPIFFE (**S**ecure **P**roduction **I**dentity **F**ramework **F**or **E**veryone) is a standard for securing and identifying workloads in a production environment. It is a secure and automated way to manage workload identity.

SPIFFE’s *Workload API* issues SVIDs (**S**PIFFE **V**erifiable **I**dentity **D**ocuments) to new workloads. An SVID is a bundle of PKI certificates and keys that proves that a workload is what it claims to be. Among other things, it contains a workload’s SPIFFE ID, encoded in a cryptographically-verifiable document. 

Additionally, all of the private keys (and corresponding certificates) in an SVID have three characteristics: they’re short-lived, they’re rotated frequently, and they’re rotated automatically. This minimizes exposure from a key being leaked or compromised.

How does a workload get an SVID from SPIFFE’s Workload API?

When a workload calls the Workload API, the Workload API does not require that a calling workload have any knowledge of its own identity, or possess any authentication token. This means your application need not co-deploy any authentication secrets with the workload. How does that work?! Well, to establish identity, the Workload API can verify the workload by querying other stuff in the environment. The exact verification process is configured by the user when setting up the SPIFFE implementation. Some examples of how a workload’s identity might be established include: the Workload API might query the kubelet, it might query the OS, and/or it might check a SHA hash. There are many, many possibilities here. 

Then, once the workload’s identity is initially established and verified, SPIFFE’s Workload API issues that workload its SVID. Depending on how a system is configured, the workload might use that SVID to communicate securely with another workload that has an SVID. Or the SVID could allow the workload to authenticate securely to a database, for example, or even to authenticate to another organization. And it isn’t always about authentication or even authorization. The workload’s identity might be used for observability purposes, say, to keep track of everything that workload does during its lifetime.

But, to be crystal clear: SPIFFE is only concerned with identity. The systems that the established identities can connect to, and what systems and tools do with those identities once authenticated is of no concern to SPIFFE. 

[![Solving for the Bottom Turtle with SPIFFE and SPIRE](https://img.youtube.com/vi/T-LI-evwV0w/0.jpg)](https://youtu.be/T-LI-evwV0w)
* [Official site](https://spiffe.io/)

## Choice 1: SPIRE

SPIRE (**SPI**ffe **R**untime **E**nvironment) is a reference implementation of SPIFFE that performs node and workload attestation in order to securely issue SVIDs to workloads. It also verifies the SVIDs of other workloads based on a configurable, predefined set of conditions. 

A SPIRE deployment is composed of a *SPIRE Server* (typically a stateful set) and one or more *SPIRE Agents* (typically a daemon set).

The Spire Server acts as a Certificate Authority (CA) for identities issued to a set of workloads via Spire Agents. The Spire Server also manages the storage: it stores and distributes SVIDs, and it stores the conditions that must be met for identities to be issued. The behavior of the SPIFFE Server is determined through a series of plugins, for example, node attestor plugins (to verify the identity of the node), datastore plugins (to store or query external information), key manager plugins (to control how the server stores private keys), or upstream authority plugins (to use a different Certificate Authority (CA) from a different PKI system).

The Spire Agents run one on each node and they do the work of exposing the Workload API to the workloads on the node, attesting the identity of workloads that call it, and if successfully verified, providing the workloads with their SVIDs. Like the SPIRE Server, the behavior of the SPIRE Agents is also configured through a series of plugins, most notably the workload attestor plugin. 

* [Official site](https://spiffe.io/docs/latest/spire-about/)

## Choice 2: Athenz

Athenz provides service authentication by issuing identities to all registered workloads, and it provides a role-based authorization system for those workloads. With Athenz, private keys (and their associate certificates) are generated by the workloads themselves, and Athenz can act as the CA.

Like SPIRE, Athenz has a server that communicates with one or many Athenz agents. The Athenz agents run alongside the workloads as sidecars and do the work of generating private keys for the workloads, collecting attestation data, generating certificate signing requests (CSRs), and submitting all of this to the Athenz server. The Athenz server validates the attestation data and acts as a CA, signing the CSR and issuing the X.509 certificate to the workload. 

Athenz promotes the use of short-lived X.509 certificates. You can configure how long a workload’s certificate lives, and the process of refreshing certificates is secure and automated. 

Athenz additionally provides a role-based authorization system for workloads. In addition to establishing workload identity, it can also assign roles to workloads by issuing access tokens to them, based on OAuth2 access token standards. Athenz prevents replay attacks (where an access token is hijacked and reused) by inspecting a workload’s X.509 certificate to further validate its access token. 

Athens supports SPIFFE’s SVIDs for identity.


[![Service Identity Authentication and Authorization Using Athenz](https://img.youtube.com/vi/kz2JXQCdE2w/0.jpg)](https://youtu.be/kz2JXQCdE2w)
* [Official site](https://www.athenz.io/)

## What Is Your Choice?

* [SPIRE](spire.md)
* **Athenz** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
