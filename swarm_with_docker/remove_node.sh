#!/bin/bash

display_usage() {
    echo "Remove a worker node from the swarm."
    echo -e "\nUsage:\n$0 [worker index]"
}

# If less than two arguments supplied, display usage 
if [ $# -ne 1 ]; then 
    display_usage
    exit 1
fi 

NODE_ID=$1
docker stop worker-${NODE_ID}
docker node rm worker-${NODE_ID}
