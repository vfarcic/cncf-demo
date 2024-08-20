# Manage DB Schema

Hero is beyond thrilled to have a database! A sidekick! Hero names their new friend 'Lil DeeBee' and, after polite introductions, Hero requests that Lil DeeBee carry around some of this cumbersome data. But in order for Lil DeeBee to do that, it would be wise Lil Deebee to know thyself and establish a database schema.

A database schema defines how data is organized within a relational database. The schema additionally describes how the data may relate to other tables or other schemas. A schema might define, for example, what tables are in a database, the names of those tables, what fields (columns) are included in each table, and what type of data should go in those fields.

For Lil DeeBee, having organized data helps Hero access the data that they need efficiently. And it allows Lil DeeBee to set clear boundaries about who is able to access what data. 

Hero and Lil DeeBee can agree that knowing what you're about and establishing clear boundaries are two keys to a happy existence. 

[![Manage DB Schema - Feat. SchemaHero And Liquibase (You Choose!, Ch. 1, Ep. 6)](https://img.youtube.com/vi/6YW2__HUHxw/0.jpg)](https://youtu.be/6YW2__HUHxw)

## Choice 1: SchemaHero

SchemaHero is a Kubernetes operator that enables you to define and manage database schemas in a language-agnostic and declarative way. With SchemaHero, you declare your desired schema, and SchemaHero will generate the steps needed to bring the actual schema state in sync with your desired schema state. If you like, you can see these changes (and run policy enforcement on them) before they're applied to your database. Declarative database management with SchemaHero also enables a GitOps approach to database schema changes.

[![SchemaHero - Database Schema Migrations Inside Kubernetes](https://img.youtube.com/vi/SofQxb4CDQQ/0.jpg)](https://youtu.be/SofQxb4CDQQ)
[![Declarative Database Schema Migrations with SchemaHero](https://img.youtube.com/vi/X0wbq7-VwdI/0.jpg)](https://youtu.be/X0wbq7-VwdI)
* [Official site](https://schemahero.io)

## Choice 2: Liquibase

Sometimes, especially from a data safety perspective, you want to dictate how your database's end state is reached. Liquibase is an open-source database schema change management solution. With it, you can manage revisions of your database. This additionally enables you to deploy (and roll back) changes to specific database versions without needing to know what has already been deployed. You can also deploy database and application changes simultaneously so that they always stay in sync.

* [Official site](https://www.liquibase.org)

## What Is Your Choice?

* [SchemaHero](schemahero.md)
* [Liquibase](liquibase.md)