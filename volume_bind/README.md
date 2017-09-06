This is a quick test of a very simple docker image what writes files
to the local folder using the bind mount. This is demonstrated using
docker run for a single container and a docker swarm service with a replication
set of 2 that can be started with `docker stack deploy` or via the docker python
API.

To use with the docker engine:
```
docker-compose build
docker-compose run --rm file_writer
```

To use with docker swarm (use docker-compose build first to build the image):
```
docker stack deploy -c docker-stack.yml test
docker stack rm test
```

To start the service with the python API use:
```
python3 launch_service.py
```
