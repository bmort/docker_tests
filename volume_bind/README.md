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
