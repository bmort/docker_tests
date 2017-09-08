#!/bin/bash
rm -f ./output/temp_*.txt
docker network prune -f
docker image prune -f 
