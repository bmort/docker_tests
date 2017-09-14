#!/bin/bash

display_usage() {
    echo "Add worker nodes to a docker swarm using docker-in-docker \
          containers."
    echo -e "\nUsage:\n$0 [No. workers]"
}

# if less than two arguments supplied, display usage 
if [ $# -ne 1 ]; then 
    display_usage
    exit 1
fi 

NUM_WORKERS=$1
echo "Adding ${NUM_WORKERS} worker nodes to the swarm."

# get join token
SWARM_TOKEN=$(docker swarm join-token -q worker)

# get Swarm master IP (Docker for Mac xhyve VM IP)
SWARM_MASTER=$(docker info | grep -w 'Node Address' | awk '{print $3}')

# Create workers
for i in $(seq "${NUM_WORKERS}"); do
    echo "Creating worker ${i} ..."
    docker node rm worker-${i}
    docker run --rm -d --privileged --name worker-${i} --hostname=worker-${i} -p ${i}2375:2375 docker:17.07.0-ce-dind 
    docker --host=localhost:${i}2375 swarm join --token ${SWARM_TOKEN} ${SWARM_MASTER}:2377
done


# if docker node ls > /dev/null 2>&1; then
#   echo this is a swarm node
# else
#   echo this is a standalone node
# fi