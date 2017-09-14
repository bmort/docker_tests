# Docker swarm cluster using docker containers

## Introduction

The following script can be used to create a Docker swarm cluster on a
single machine by using a set of
[docker in docker](https://hub.docker.com/_/docker/) containers.

The script is based on instructions found at
<http://blog.terranillius.com/post/swarm_dind>

## Instructions

This script assumes that docker is installed on the host machine which the
cluster is to be created. This could be a development machine such as a
desktop or laptop. This could be a linux, windows, or mac os based machine.
To install the docker engine see <https://www.docker.com/community-edition#/download>.

The script assumes that the host machine has already been initialised 
as a swarm manager. This can be checked with the command:

```shell
docker node ls
```

and if not already initialsed as a swarm manager, a swarm can be initialised 
with the command:

```shell
docker swarm init
```

Once initialised additional worker nodes can be added to the swarm by
running the script `create_workers.sh`.

Nodes created using this script can be removed from the cluster using the 
commands:

```shell
docker stop worker-<id>
docker node rm worker-<id>
```

where `<id>` is index of the node to be rmeoved and the name of the docker
node hostname and container name which it was created with.

## Useful commands

- Destroy the swarm cluster
  ```shell
  docker swarm leave --force
  ```
- To clean up a docker installation
  ```shell
  docker system prune -f
  ```
- To launch a simple web application to visualise the swarm. Once this 
  container started, visit <http://localhost:8080>.
  ```shell
  docker run -it -d \
    -p 8080:8080 \
    -v /var/run/docker.sock:/var/run/docker.sock \
    dockersamples/visualizer
  ```