# ELK stack example deployed though docker swarm

This is a quick test of ELK stack deployed through docker swarm.

## Usage

### Create a swarm

Create a 3 node docker swarm cluster using docker-machine.

Create the nodes:

```shell
docker-machine create manager
docker-machine create agent1
docker-machine create agent2
```

Set `vm.max_map_count` in each of the VMs so that elasticsearch does not give 
`Out of Memory` errors (<https://www.elastic.co/guide/en/elasticsearch/reference/current/vm-max-map-count.html>). 

```shell
docker-machine ssh manager sudo sysctl -w vm.max_map_count=262144
docker-machine ssh agent1 sudo sysctl -w vm.max_map_count=262144
docker-machine ssh agent2 sudo sysctl -w vm.max_map_count=262144
```

Switch the context to the docker engine of the manager node:

```shell
eval `docker-machine env manager`
```

Create the swarm:

```shell
docker swarm init --advertise-addr `docker-machine ip manager`
docker-machine ssh agent1 docker swarm join --token `docker swarm join-token -q worker` `docker-machine ip manager`:2377
docker-machine ssh agent2 docker swarm join --token `docker swarm join-token -q worker` `docker-machine ip manager`:2377
```

### Deploy the ELK stack

```shell
docker stack deploy -c elk.yml elk
```

### Check that the stack has been deployed

```shell
docker stack services elk
docker stack ps elk
```

### Test using a container printing to stdout

```shell
docker stack deploy -c log_spammer.yml spammer
```

### Test using a container using python-logstash handler

Note this container will fall back to stdout if the logstash udp socket cannot
be resolved. This will be the case if the container is not run in the same
overlay network as the logstash endpoint.

```shell
docker service create --network elk_default -d bmort/logging_spammer
```

or 

```shell
docker stack deploy -c logging_spammer.yml spammer2
```

### Clean up stacks and machines

```shell
docker stack rm spammer
[docker stack rm spammer2]
docker stack rm elk
docker-machine stop manager agent1 agent2
docker-machine rm manager agent1 agent2
```

## Configuring Kibana

See <https://www.youtube.com/watch?v=mMhnGjp8oOI> for an introduction to 
Kibana 5.

## TODO

- Add logtrail to kibana <https://github.com/sivasamyk/logtrail>
  - <https://www.elastic.co/blog/elasticsearch-docker-plugin-management>
- Need to impose an ordering on starting containers in the stack?
  - <https://stefanprodan.com/2017/docker-log-transport-and-aggregation-at-scale/>

## References

- <https://botleg.com/stories/log-management-of-docker-swarm-with-elk-stack>
- <https://github.com/botleg/swarm-logging>
- <https://botleg.com/stories/monitoring-docker-swarm-with-cadvisor-influxdb-and-grafana/>
- <https://logmatic.io/blog/docker-logging-guide/>
