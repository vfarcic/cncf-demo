# Develop The Application With Devfile

Devfile is the technology that drives the consistent and automated development environment setup. To make use of devfile, we’ll need to use a tool that understands devfile and there are a couple of choices out there. We’ll choose a CLI called odo that helps you to develop your application in a Kubernetes environment.

We’ll download a simple Node Application from the community devfile registry and run it instead of creating something from scratch. 

## Setup
* Install [`odo` CLI](https://odo.dev/docs/overview/installation)
* Have a Kubernetes environment setup and already login from your machine using `kubectl`

## Do

1. Create a new directory and `cd` into it.
    ```bash
    mkdir devfiledemo
    cd devfiledemo
    ```
1. Download a sample Node.js application from the devfile registry (press `Enter` for default selection)
    1. `odo init`
    1. Select `JavaScript`
    1. Select `Node.js Runtime` (default)
    1. Select `NONE - configuration is correct` (default)
    1. Select `nodejs-starter` (default)
    1. Choose your component name, e.g. `devfiledemo` (default)
    1. You can see a sample application has been created with a devfile.yaml
1. Start the inner-loop development:
    ```bash
    odo dev
    ```
1. Wait a few seconds until `odo dev` displays `Forwarding from 127.0.0.1:..`. in its output, meaning that odo has successfully set up the port forwarding to reach the application running in the container.
1. Open the URL from a browser, e.g. `http://127.0.0.1:20001/`(port number may be different, use the same URL from #3)
1. Change something on `server.js` file, e.g. change the string on line 55 
    ```js
    res.send('Hello from Node.js Starter Application!');
    ```

1. You can see on `odo dev` that it automatically syncs the changes to the cluster
1. Reload the browser to see the changes
1. Press `[Crtl+c]` on the `odo dev` to exit

## Continue The Adventure

[Create And Manage Production Kubernetes Cluster](../cluster/README.md)
[Destroy Everything](../destroy-all.md)
