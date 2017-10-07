#!/bin/bash

#
# Script to initialise docker-machine VMs for running this ELK stack example
#
# Run with:
#   ./local_swarm.sh [mode]
#

NORMAL=$(tput sgr0)
GREEN=$(tput setaf 2; tput bold)
YELLOW=$(tput setaf 3)
RED=$(tput setaf 1)

function error() {
    echo -e "$RED$*$NORMAL"
}

function info() {
    echo -e "$GREEN$*$NORMAL"
}

function warn() {
    echo -e "$YELLOW$*$NORMAL"
}

function create_node() {
    STATUS=$(docker-machine status "$1" 2> /dev/null)
    NODES+=("$1")
    if [ -z "$STATUS" ]; then
        info "Creating node: $1 ..."
        docker-machine create \
        --virtualbox-cpu-count "2" \
        --virtualbox-memory "2048" \
        "${1}"
        info "> Setting vm.max_map_count=262144"
        docker-machine ssh worker1 sudo sysctl -w vm.max_map_count=262144
    else
        warn "> Node '$1' already exists. Status = $STATUS."
    fi
}

function usage() {
    echo "Usage: $0 [mode == (start|rm)]"
}

if [ $# -ne 1 ]; then
    usage
    exit 1
fi

mode="$1"

case $mode in
    start|up)
        info "Starting local swarm cluster."
        create_node manager
        eval "$(docker-machine env manager)"
        docker swarm init \
            --advertise-addr "$(docker-machine ip manager)" \
            2> /dev/null
        create_node worker1
        docker-machine ssh worker1 \
            docker swarm join \
            --token "$(docker swarm join-token -q worker)" \
            "$(docker-machine ip manager)":2377 \
            2> /dev/null 
        info "Replacing the current shell to export the docker "\
             "daemon in node 'master'."
        info "Running: 'exit' will return to the orignal shell."
        exec "$SHELL" --init-file "${HOME}"/.bash_profile -i
        ;;
    rm|clean)
        info "Removing local swarm cluster"
        docker-machine rm manager worker1 -f
        ;;
    *)
        error "unrecognised argument: $mode"
        usage
        ;;
esac




# create_node manager
# create_node worker1

# Create the swarm
# docker swarm init --advertise-addr "$(docker-machine ip manager)"
# docker-machine ssh worker1 \
#     docker swarm join \
#     --token "$(docker swarm join-token -q worker)" \
#     "$(docker-machine ip manager)":2377

# # Add a label to the worker to make sure the
# docker node update --label-add elk_db=true worker1
# eval "$(docker-machine env manager)"