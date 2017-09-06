#!/bin/bash
rm -f ./temp_*.txt
docker network prune -f
docker image prune -f 
