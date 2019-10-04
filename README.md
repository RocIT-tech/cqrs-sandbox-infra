# Install
## Env variables
````bash
# nginx.env
APP_NGINX_HOST=local.cqrs.roc-it.tech
APP_FPM_HOST=php
````

````bash
# php.env
PHP_XDEBUG_ENABLED=1
APP_SWITCH_ENV=true

# Host = docker network inspect "${NETWORK_NAME:?}" -f "{{range .IPAM.Config }}{{ .Gateway }}{{end}}"
# Port = ARBITRARY
XDEBUG_CONFIG=remote_host=172.28.0.4 remote_port=30093
````

````bash
# postgres.env
LC_ALL=C.UTF-8
POSTGRES_USER=cqrs
POSTGRES_PASSWORD=cqrs
POSTGRES_DB=cqrs
````

````bash
# traefik.env
````

## Specific files
```bash
$ touch ./build/traefik/tls/acme.json
$ chmod 644 ./build/traefik/tls/acme.json
```

## Compiling the compose files
### Local
```bash
$ docker-compose \
    -f ./docker-compose.yml \
    -f ./env/local/docker-compose.traefik.yml \
    -f ./env/local/docker-compose.local.yml \
    -f ./env/local/docker-compose.local.traefik.yml \
    config \
> ./docker-compose.compiled.yml
```

## Running the containers
### Local
```bash
$ docker-compose -p cqrs-sandbox -f ./docker-compose.compiled.yml pull; \
docker-compose -p cqrs-sandbox -f ./docker-compose.compiled.yml up -d --remove-orphans --build
```
