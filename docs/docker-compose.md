# docker-compose

Docker compose allows a mechanism to run the entire project stack using docker containers.
Docker compose unfortunately offers no live reload of services when changes are made.

## build

build container images from local sources

```sh
docker-compose build
```

## start stack/service

start the full stack or optionally a single service

```sh
docker-compose up [service]
```

## stop stack/service

stop the full stack or optionally a single service

```sh
docker-compose down [service]
```
