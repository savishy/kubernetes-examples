# Node-Kubernetes-Docker-Google Cloud Engine #

This example runs a Dockerized Node application as a Kubernetes pod in Google Cloud.

### Prerequisites ###

1. A Docker Hub account. Needed for pushing your containizered application image.
2. A working Docker installation e.g Docker Toolbox on Windows or Docker Engine on Linux.
3. *Ruby Script may not work properly on Windows.*
4. An Google Cloud project for Kubernetes should already have been created. Store the project ID in `config.json`, under the key `gce_project`.

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

### Cleaning up ###
After your run you can clean up your efforts by running `cleanup.rb`.
This will
* delete the load-balancer and deployments
* delete the google cloud container cluster.
