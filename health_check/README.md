# A test of the Docker healthcheck API

Based on blog post found [here](https://howchoo.com/g/zwjhogrkywe/how-to-add-a-health-check-to-your-docker-container).

Build with:

```shell
docker-compose build
```

Run with:

```shell
docker-compose run --rm --service-ports -d test_app
```

or

```shell
docker-compose up -d
```

Check health with:

``` shell
docker ps
```

and:

```shell
docker inspect --format='{{json .State.Health}}' <container id>
```

End the test with:

```shell
docker-compose down
```
