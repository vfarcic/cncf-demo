# Signing Artifacts

Hero is sitting pretty in production. The neighboring apps and objects all belong, Hero feels protected against unknown unknowns at runtime, and Hero can safely and easily access needed secrets. Hero is only allowed to communicate with necessary services, and those communications are secure. The cluster has been scanned for security vulnerabilities and misconfigurations, and all risks and threats have been addressed. So can Hero and Lil DeeBee finally relax already?!

Nope!

There is another threat boundary to consider - container images! Sure they all look like they’re from familiar, trusted sources but those pesky little gremlins can’t be trusted! Some are dressed up to look safe but when run they’ll fire up malicious code that can hurt Hero and the system! Code might be containerized by an attacker and made to look like familiar images, or an image might be from a truly trusted source but then modified by an attacker in transit.

And now that Hero knows that images might be nefarious, Hero sees them everywhere! There are application code images like Hero, base images for those app images, images that run third-party tools (like every tool we’ve added so far in the story!), and images made in-house, to name a few. How can Hero know that they’re all safe to run?!

There are other artifacts all over the system too - Helm charts, policies, release files, binaries, software bill of materials (SBOMs), et cetera - all of which can be hijacked and modified. Hero is shaking in fear!

That is where **artifact signing** swoops in to save the day! Signing can give Hero piece of mind that artifacts in the cluster have authenticity, meaning they come from a trusted source, and the artifacts have integrity, meaning they have not been tampered with. 

What does it mean to sign a digital artifact? A statement called an *attestation* makes a claim about the artifact (for example, the trustworthiness of the origin) and the artifact signature verifies the attestation. The signature has an associated X.509 certificate to establish the identity of the signing party. So basically, an attestation is a statement that is signed by a particular identity (human or process) at a point in time. Attestations and X.509 certificates are stored alongside artifacts and move between registries and systems together. So, if an artifact is signed, that means that its metadata points to a signed attestation and X.509 certificate that makes some claim about that artifact. Note here that you still have to trust the human or entity that is making the claim - the signature verifies the identity of the attestation author but not the truthfulness of the claim itself. Meaning people and processes can still lie right to your face.

There are many types of artifacts, verifying tools, and strategies. For example, container images are often verified as part of the pulling process, and SBOMs might get verified, appended with new information, and re-signed as software moves through a supply chain.

Let’s investigate some signing tools now!


## Choice 1: Notary Project

**Notary Project** is a specification that defines how a signature is created. The specification includes encryption standards, signature formats, and a spec for how to generate signatures. Notary Project additionally includes specifications for signature verification and for extendability with plugins.

**Notation** is a Notary project tool that implements the Notary Project specification. Notation can be used as a CLI tool or as libraries.

**Notary** is a legacy client/server for signing images.

With Notary Project, a user can specify verification levels like *strict*, *permissive*, *audit*, and *skip*, which helps to incrementally adopt signatures. 

Notary Project also provides granularity with signature revocations. You can choose to revoke an individual signature (for example, revoke one particular image built by the owner of this particular private key), or you can revoke a whole identity (for example, revoke every image built by the owner of this particular private key). 

Notation plugins include signing plugins that integrate Notation with third-party key management systems, verification plugins that extend signature verification logic, and you can build your own plugins to help integrate Notary Project with your signing infrastructure.

However, the main differentiator between Notary Project and Sigstore is that Sigstore publishes signatures to an immutable, transparent public log (this simplifies key management - more about that in a moment), and Notary Project does not. Therefore Notary Project shines in use cases where privacy and compliance are significant concerns, like for air-gapped and/or highly regulated systems.


[![Ensuring Software Authenticity: Introduction to Notary Project](https://img.youtube.com/vi/GaCAiwb3Mhw/0.jpg)](https://youtu.be/GaCAiwb3Mhw)
* [Official site](https://notaryproject.dev)

## Choice 2: Sigstore

Sigstore is a set of tools that handle digital signing, verification, and more - making it safer to distribute and use open source software. These tools are **Cosign**, a tool that handles container signing and verifying, **Fulcio**, Sigstore’s Certificate Authority, and **Rekor**, software that adds a timestamp to the signature of the attestation and then persists the signing event to immutable, transparent, tamper-resistant public logs. 

You may be asking yourself, why bother with public logs? Seems like a lot of extra headache. Here’s what makes Sigstore special: in Sigstore, private keys are ephemeral! Disposable! No key management is needed! Certificates don’t need to be renewed!

How is that possible?!? The private/public key pair is created and only valid for a very short ten-minute window. The Sigstore certificate is used to sign the attestation at that time. Rekor then adds a timestamp to the signature and then adds the signing event to the public logs. The signing event contains metadata only, not any details about the attestation itself. Then, when the artifact signature is verified, among other things the verifier is checking that the Sigstore certificate was issued by Fulcio, that it was signed at the right time, and that the Sigstore certificate and timestamp are in the public record. 

Sigstore is difficult to understand but simple to use. Besides not needing key management, Sigstore also uses popular digital identity providers alike Google and GitHub to establish identity to actors in a system (including both humans and processes).


[![Signed, Sealed, Delivered, I’m Yours! An Introduction to Sigstore](https://img.youtube.com/vi/Q726pjHLsiE/0.jpg)](https://youtu.be/Q726pjHLsiE)
[![Signing and Verifying Container Images With Sigstore Cosign and Kyverno](https://img.youtube.com/vi/HLb1Q086u6M/0.jpg)](https://youtu.be/HLb1Q086u6M)
* [Official site](https://www.sigstore.dev/)


## Choice 3: Open Policy Containers

Open Policy Containers (OPCR) takes a collection of Open Policy Agent (OPA) policy-related artifacts and stores them as an Open Container Initiative (OCI) v2 container image, which allows the user to package and distribute OPA policies in a way that leverages industry standards. Because the policy is now an OCI container image, users can additionally version their policies, and add any other metadata that they please. 

Admittedly, Open Policy Containers doesn’t fit very snugly into this “Artifact Signing” system design step, but it does use Sigstore’s *Cosign* tool under the hood to sign and verify the OCI policy artifacts that it creates.

[![Open Policy Containers: The What, Why, and How](https://img.youtube.com/vi/gCPDSni9rXY/0.jpg)](https://youtu.be/gCPDSni9rXY)
* [Official site](https://openpolicycontainers.com/)

## What Is Your Choice?

* [Notary Project](notary.md)
* [Sigstore](sigstore.md)
* **Open Policy Containers** has not yet been implemented. Please let us know (by opening an issue) if you would like to contribute the implementation.


