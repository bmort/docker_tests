#!/bin/bash

# Create the manager node
docker-machine create --virtualbox-cpu-count "2" --virtualbox-memory "2048" manager
docker-machine ssh manager sudo sysctl -w vm.max_map_count=262144

# Create the worker node
docker-machine create --virtualbox-cpu-count "2" --virtualbox-memory "2048" worker1
docker-machine ssh worker1 sudo sysctl -w vm.max_map_count=262144

sleep 1

# Switch to the docker engine of the manager node
eval `docker-machine env manager`

# Create the swarm
docker swarm init --advertise-addr `docker-machine ip manager`
sleep 1
docker-machine ssh worker1 docker swarm join --token `docker swarm join-token -q worker` `docker-machine ip manager`:2377

