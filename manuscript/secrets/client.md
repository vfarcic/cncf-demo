# Secrets Management Outside Kubernetes

TODO: Intro

## Choice 1: Secrets OPerationS (SOPS)

Secrets OPerationS (SOPS) is a CLI tool that simplifies the process of encrypting and decrypting files containing secrets. SOPS works by encrypting the contents of a file, which can then be safely committed to a version control system like Git. When access to the secrets is required, SOPS decrypts the file and ensures that only authorized individuals or systems can view or use the sensitive data.

SOPS works with many file types, including YAML, JSON, and ENV, and supports multiple encryption methods, such as PGP, AWS Key Management Service (KMS), and Google Cloud KMS. It also supports role-based access control.

* [Official site](https://getsops.io)

## Choice 2: Teller

Teller is a secrets management command-line tool that provides a centralized hub for managing secrets from over 10 different vault and keystore providers. 

Having one access point to many vaults helps to make it easier for users to track, manage, use, and rotate secrets—while adding security by reducing the attack surface. 

Teller minimizes the amount of time that a secret is used by operating entirely in-memory, as well as by fetching and populating secrets just in time. At no point are secrets written to disk. 

[![Secrets Made My Life Miserable - Consume Secrets Easily With Teller](https://img.youtube.com/vi/Vcjz-YM3uLQ/0.jpg)](https://youtu.be/Vcjz-YM3uLQ)
* [Official site](https://tlr.dev)

## What Is Your Choice?

* [Teller](teller.md)
* [Secrets OPerationS (SOPS)](sops.md)
