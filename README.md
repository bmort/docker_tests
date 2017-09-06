docker image prune -f
docker network prune -f
docker volume prune -f

docker-compose build
docker-compose run --rm file_writer

docker stack deploy -c docker-stack.yml test
docker stack rm test
