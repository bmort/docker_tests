# Test commands

## Docker exposing and publishing ports (from <https://docs.docker.com>)

- Exposing ports is done with `EXPOSE` in the dockerfile, or `--expose` when
  using `docker run`. This is a way of documenting which ports are used but
  does not map or open any ports. Exposing is optional.
- Ports are published with the `PUBLISH` keyword in the dockerfile, or
  the `--publish` flag to `docker run`. When a port is published, it is mapped
  to am available port (> 30000) unless you specify the port to map to on the host machine at runtime. This can not be done in the dockerfile as there
  is no way to guarantee that that port will be available on the ost machine
  where you run the image.
- To publish a port use the `-p` option. eg. `-p 80` will publish port 80
  of the container to a random port > 30000, and `-p 8080:80` will publish
  port 80 of the container to port 8080 on the host machine. This will
  fail if port 8080 is not available.

## Creating a test swarm cluster

A script to start a 3 node cluster using docker-machine is provided.
This script creates the nodes, initialises the swarm and sets the enviromnent
variables needed to acess the docker daemon in the manager node VM.
The enviroment variables are set by starting a new shell session in the current
terminal. To return to the docker environemnt of the host use the `exit`
command.

```bash
./swarm.sh start
```

Other than `start` the script takes the arguments:

- `connect` which sets up enviromnent variables needed to expose docker daemon
  in the manager VM. This works for the current terminal session only by
  starting a new shell. Type `exit` to exit this shell and return to the
  docker environment of the host.
- `rm` which removes all VMs created by the script.


## Building test containers (optional - they are on dockerhub)

```bash
docker-compose build
```

## Running and testing with `docker service create`

Run as service exposing port:

```bash
docker service create --name f -p 5502:5502 bmort/flask_hello
```

Run as service on host network:

```bash
docker service create --name f --network host bmort/flask_hello
```

Check:

```bash
curl $(docker-machine ip manager):5502
```

## Running and testing with `docker stack deploy`

Start the stack using:

```bash
docker stack deploy -c docker-stack.yml test
```

This will create two replicated services, one using host networking and one
using a published port. Starting the stack will also attach all containers
to an overlay network `test_default`.

To test the service using published ports:

```bash
curl $(curl docker-machine ip [node]):5602
```

```bash
curl $(curl docker-machine ip [node]):5502
```

---
## Connecting to the udp socket server with netcat

If starting the socket server on localhost:

```bash
cat - | nc  -4u localhost 8888
hello
```
