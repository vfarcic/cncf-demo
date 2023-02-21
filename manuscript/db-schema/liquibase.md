# Manage DB Schema With Liquibase

The recommended way to use Liquibase in Kubernetes is with Init Containers. This will guarantee the Liquibase process will not be interupted by application issues. Also, if you have problems with your Liquibase update process, your application will not be affected.


## How Liquibase Works

Liquibase updates your database schema using migrations performed sequentially. With an artifact file, ChangeLog, Liquibase connects to the database, sees that last migration executed on the database, and executes any missing migrations. 

## Example 

```
apiVersion: v1
kind: Pod
metadata:
  name: my-app-pod
spec:
  initContainers:
  - name: liquibase
    image: liquibase/liquibase:latest
    command: ["liquibase", "update", "--changeLogFile=path/to/changelog.xml"]
    env:
    - name: LIQUIBASE_URL
      value: "jdbc:postgresql://postgres:5432/mydb"
    - name: LIQUIBASE_USERNAME
      value: "myuser"
    - name: LIQUIBASE_PASSWORD
      value: "mypassword"
    volumeMounts:
    - name: changelog-volume
      mountPath: /path/to
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
  - name: changelog-volume
    configMap:
      name: my-app-changelog
```
