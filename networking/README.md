# Test commands

Findings from Flask hello test:

- If creating the service with docker service create --network host works and
  allows the container to access host network without exposing ports.
- This can be verified with `curl` which works without exposing ports if the
  `--network host` is passed to the create command but no connection can be
  found if this option is not passed unless ports are published from the
  container with `-p`.
- There is big difference here in what is reported from the host string.
  If running with `-p` the host == container name, if running with
  `--network host` the host will be the ip or hostname of the VM.

## Connecting to the flask hello world server

Build:

```bash
docker build -t flask_hello ./flask_server
```

Run:

```bash
docker service create --name f -p 5502:5502 flask_hello
```

```bash
docker service create --name f --network host flask_hello
```


Check:

```bash
curl $(docker-machine ip manager):5502
```

## Connecting to the udp socket server with netcat

If starting the socket server on localhost:

```bash
cat - | nc  -4u localhost 8888
hello
```

## Create swarm cluster of VMs

```bash
./swarm start
```

## Deploy using stack file

```bash
docker stack deploy -c docker-stack.yml test
```

## Default networking

```bash
docker service create \
    --name dn \
    --mode global \
    --tty \
    --detach=false \
    alpine:3.6 \
    sleep 3600
```

```bash
docker ps
```

```bash
docker exec [container id] ifconfig
```

```bash
docker service rm dn
```

## Host networking

```bash
docker service create \
    --name hn \
    --mode global \
    --tty \
    --network host \
    alpine:3.6 \
    sleep 3600
```

```bash
docker ps
```

```bash
docker exec [container id] ifconfig
```

```bash
docker service rm dn
```

```bash
docker service rm hn
```