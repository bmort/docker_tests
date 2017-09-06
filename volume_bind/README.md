## Test of a container writing a file to a bind mount 

This is a quick test / demo of a very simple docker image what writes files
to the local folder using the bind mount. This is demonstrated using
docker run for a single container and a docker swarm service with a replication
set of 2 that can be started with `docker stack deploy` or via the docker
python API.


1. To use with the docker engine:
```
docker-compose build
docker-compose run --rm file_writer
```

2. To use with docker swarm (if skipping step 1, use `docker-compose build`
first to build the image):
```
docker stack deploy -c docker-stack.yml test
docker stack rm test
```

3. To start the service with the python API use (if skipping step 1,
use `docker-compose build` first to build the image):
```
python3 launch_service.py
```
