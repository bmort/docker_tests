# Steps required for P3

## Useful magnum commands

```shell
magnum cluster-list
magnum cluster-show [cluster name]
magnum cluster-env [cluster name] > cluster-env
```

## Set `vm.max_map_count=262144`

For each node in the swarm run the command:

```shell
ssh -i [node key] fedora@[node ip]  sudo sysctl -w vm.max_map_count=262144
```

## Label the elasticsearch db node

Label the node which should be used for the elasticsearch db:

```shell
docker node update --label-add elk_db=true [node id]
```
