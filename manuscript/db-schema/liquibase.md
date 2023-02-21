# Manage Database Schema With Liquibase

The recommended way to use Liquibase in Kubernetes is with Init Containers. This will guarantee the Liquibase process will not be interupted by application issues. Also, if you have problems with your Liquibase update process, your application will not be affected.

### A Note about "Schemaless" Databases

Liquibase supports "schemaless" databases, such as MongoDB. The use case for Liquibase is creating collections, indexes, the bulk creation of documents, and more. Simply because your database does not have an RDBMS schema, you can still benefit from database automation in your CI/CD process. 

## How Liquibase Works

Liquibase updates your database schema using migrations performed sequentially. With an artifact file, ChangeLog, Liquibase connects to the database, sees that last migration executed on the database, and executes any missing migrations. 

## Example 

The best practice to run Liquibase in Kubernetes is to use an init container in Kubernetes. To do so, create a Pod that includes the Liquibase init container and your main application container. The init container will run Liquibase to update the database schema before the main application container starts.

Here is an example of how to configure a Pod with a Liquibase init container:

```
apiVersion: v1
kind: Pod
metadata:
  name: my-app-pod
spec:
  initContainers:
  - name: liquibase
    image: liquibase/liquibase:latest
    command: ["liquibase", "update", "--changeLogFile=/liquibase/changelog/changelog.xml"]
    env:
    - name: LIQUIBASE_URL
      value: "jdbc:postgresql://postgres:5432/mydb"
    - name: LIQUIBASE_USERNAME
      value: "myuser"
    - name: LIQUIBASE_PASSWORD
      value: "mypassword"
    volumeMounts:
    - name: liquibase-changelog-volume
      mountPath: /liquibase/changelog
  containers:
  - name: my-app
    image: my-app:latest
    env:
    - name: DATABASE_URL
      value: "jdbc:postgresql://postgres:5432/mydb"
    - name: DATABASE_USERNAME
      value: "myuser"
    - name: DATABASE_PASSWORD
      value: "mypassword"
    ports:
    - containerPort: 8080
  volumes:
  - name: liquibase-changelog-volume
    configMap:
      name: liquibase-changelog
```

In this example, the init container is named `liquibase` and uses the `liquibase/liquibase:latest` image. The command to run is `liquibase update --changeLogFile=/liquibase/changelog/changelog.xml`. The environment variables are set to configure the connection to the database. These can also be configured using Kubernetes Secrets.

The main container is `my-app`, which uses the `my-app:latest` image and also has environment variables set to configure the connection to the database.

You should store your Liquibase ChangeLog in Kubernetes using a ConfigMap. This will allow you to mount the changelog file as a volume and allow the init container to access the changelog file.

Create a ConfigMap using the following command: 
`kubectl create configmap changelog-volume --from-file=changelog.xml`

Once you have the pod definition in a file, you can create the pod using

`kubectl apply -f my-pod-definition.yaml`

It's important to note that the init container will run before the main container starts and will exit after the update is done, if the update fails the pod will fail too and you can check the logs of the init-container to see what went wrong.


