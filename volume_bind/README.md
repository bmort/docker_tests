# Writing a file using bind mount mode

This is a quick test / demo of a very simple docker image what writes files
to the a local folder using the bind mount. This is demonstrated using docker
run for a single container and a docker swarm service with a replication set
of 2 that can be started with `docker stack deploy` or via the docker python
API.

Files are written to the `./output` directory with the name `temp_<conatinerid>.txt`. A cleanup script (`cleanup.sh`) is provided to remove hanging images and clean out output files.

## 1. Set up virtualenv

```shell
virtualenv -p `which python3` venv
. venv/bin/activate
pip install -r requirements
```

## 2. Build the image

```shell
docker-compose build
```

## 2. Run with the docker engine

```shell
docker-compose run --rm file_writer
```

## 3. Start as a service using docker stack deploy

*Note: Make sure the image has been built first see section 2.*

```shell
docker stack deploy -c docker-stack.yml test
docker stack rm test
```

## 4. Start as a service using Python API

*Note: Make sure the image has been built first see section 2.*

```shell
python3 launch_service.py
```

## 5. Running from a remote registry

This example can also be run without checking out the code from github using
the image at [hub.docker.com](https://hub.docker.com/r/bmort/file_writer/)
which is built every time a new version of the code is pushed to github.

To run this using the docker engine:

```shell
mkdir output
docker run --rm -v "$(pwd)/output":/app/output:rw bmort/file_writer:repo
```

And to run this as a service using docker swarm:

```shell
mkdir output
docker service create \
    --mount type=bind,source="$(pwd)/output",destination=/app/output \
    --replicas 2 \
    --restart-condition none \
    --detach=false \
    bmort/file_writer:repo
```

After 10 seconds the containers started by this service will finish. To clean
up the service use the command:

```shell
docker service rm <service id>
```

where the `<service id>` can be found by using the `docker service ls`
command and looking for a service with the image `bmort/file_writer:repo`.

A good place to test this in a clean hosted docker enviroment is at
[http://labs.play-with-docker.com/](http://labs.play-with-docker.com/).
