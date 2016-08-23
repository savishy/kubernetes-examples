# Node-Kubernetes-Docker-Google Cloud Engine #

This example runs a Dockerized Node application as a Kubernetes pod in Google Cloud.

### Prerequisites ###

1. A Docker Hub account. Needed for pushing your containizered application image.
2. A working Docker installation e.g Docker Toolbox on Windows.
3. If you are on windows, you will need the ability to run shell scripts e.g. Cygwin or MinGW.

### How to run ###

First, set variables:

```
DOCKER_USERNAME: your Docker Hub username (e.g docker.io/username)
DOCKER_PASSWORD: your Docker Hub password
```

Execute the `run.rb` script which does the following:

1. Logs you in to Docker Hub if needed.
1. Builds a sample `nodejs` application into a `Dockerfile`.
2. Pushes the image to Docker Hub
3. Creates a Google Cloud Container Cluster
4. Creates a Kubernetes Pod
5. Exposes the load balancer IP 
6. Prints IP onscreen.
