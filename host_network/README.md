# Test commands

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