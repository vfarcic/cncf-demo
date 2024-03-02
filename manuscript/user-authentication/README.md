# User Authentication
 
For a long time now, it has been Hero’s dream to serve end users. And now they’re doing it! Huzzah! But now Hero is realizing that end users can’t be trusted either! Can Hero trust ANYONE? Is anyone at all trustworthy here in production?

(Spoiler alert, the answer is no.)

So Hero needs to go through the rigamarole of having their human users register on their website, have a way to verify their identity, have a process in place for them to log in again on subsequent visits, and have a strategy for when the user inevitably forgets their login credentials… 

Back in the day, every app would have a custom solution for this problem, and users would need to remember a unique username and password for every website they visited. There were many different access management protocols and they didn’t necessarily play well with one another. 

Lucky for Hero, some standards have emerged in the authentication space that improve both the developer experience and the user experience. First, OpenID Connect (OIDC) decouples the process of establishing a user’s identity from the application that the user wants to log in to. OIDC defines a consistent way to verify the identity of a user to a “client service”. Hero is a client service! OIDC can also be used to establish user identity for Single Sign-On (SSO), web apps, mobile apps, edge devices, and more. One cool thing about OIDC is that it does not share the user credentials with these services, so not only is it safer for Hero, it is safer for the user too.

OIDC works in tandem with OAuth 2 (Open Authorization 2). OAuth 2 is an underlying protocol for OIDC. OAuth 2 is a protocol that emphasises authorization (access), not authentication (identity). OIDC provides an identity layer that integrates with the underlying OAuth 2 framework (that deals with access). OIDC and OAuth 2 both use tokens. Access Tokens and Refresh Tokens are defined as part of the OAuth 2 specification, and OIDC adds the concept of the ID token. 

You have likely had the user experience of using your account from an identity provider like GitHub, Gitlab, or Gmail to log in to a totally unrelated website. That’s OIDC!

Hero loves this efficiency and standardization, but they still have problems. Even with OIDC, there are so many different ways that apps across the organization are handling user identity in order to provide access to Kubernetes: service account tokens, X.509 certificates, OIDC providers, other identity providers like LDAP (Lightweight Directory Access Protocol) and SAML (Security Assertion Markup Language), authentication proxies (where identity is established before it reaches kube-api), and token webhooks, to name a few. And Kubernetes natively only accepts one identity provider per cluster!

Hero needs a CNCF tool to help them manage all of the ways that teams across the organization want to provide identity and access for the humans who want to use the applications that are running in Kubernetes. That tool should additionally provide a good experience (log-in “flow”) for that end user to register and log in.

## Choice 1: Dex

Dex is a federated OIDC provider. This means that it connects many different identity providers together so that they can talk in OIDC. With Dex you can use many identity providers such as LDAP and SAML, and you can use Dex to connect more than one identity provider to a Kubernetes cluster. 

Dex has an abstraction called a collector that connects Dex with identity providers. There are more than 15 connectors available from the Dex community, connectors such as GitHub, Gitlab, Microsoft, AuthProxy, and OpenShift. You can also build your own connector, such as a file connector or a database connector.

Dex is simple and lightweight. There are not many features by design. 

[![What Is Dex?](https://img.youtube.com/vi/6SYV9dqwHQY/0.jpg)](https://youtu.be/6SYV9dqwHQY)
* [Official site](https://dexidp.io)

## Choice 2: Keycloak

Keycloak is a full-featured IAM (Identity and Access Management) solution. 

Keycloak uses a plug-in system to provide support for many different access management protocols and many different identity providers. With Keycloak, a developer can more easily implement the following IAM features in their application:
* register users for the first time
* recover passwords
* implement multi-factor authentication (MFA)
* control how a user authenticates
* manage both users and clients
* design and implement log-in flows

[![Keycloak: The Open Source IAM for Modern Applications](https://img.youtube.com/vi/FPPFbKUZkME/0.jpg)](https://youtu.be/FPPFbKUZkME)
* [Official site](https://keycloak.org)

## What Is Your Choice?

* **Dex** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.
* [Keycloak](keycloak.md)
