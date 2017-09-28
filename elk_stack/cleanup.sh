#!/bin/bash
docker stack rm elk
docker-machine rm -y manager worker1 worker2
