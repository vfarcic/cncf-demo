# Manage DB Schema

TODO: Intro

## Choice 1: SchemaHero

TODO: Explanation

[![SchemaHero - Database Schema Migrations Inside Kubernetes](https://img.youtube.com/vi/SofQxb4CDQQ/0.jpg)](https://youtu.be/SofQxb4CDQQ)
[![Declarative Database Schema Migrations with SchemaHero](https://img.youtube.com/vi/uzWBaqPxxH8/0.jpg)](https://via.vmw.com/SchemaHero)
* [Official site](https://schemahero.io)

## Choice 2: Liquibase

Sometimes, especially from a data safety perspective, you want to dictate how your database's end state is reached. Liquibase is an open-source database schema change management solution. With it, you can manage revisions of your database. This additionally enables you to deploy (and roll back) changes to specific database versions without needing to know what has already been deployed. You can also deploy database and application changes simultaneously so that they always stay in sync.

* [Official site](https://www.liquibase.org)

## What Is Your Choice?

* [SchemaHero](schemahero.md)
* [Liquibase](liquibase.md)