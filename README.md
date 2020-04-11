# Requirements
## SSL

Install [mkcert](https://github.com/FiloSottile/mkcert) and make sure you ran at least once
```bash
$ mkcert -install
```

Then run
```bash
$ mkcert \
    -cert-file ./env/local/certs/local-cert.pem \
    -key-file ./env/local/certs/local-key.pem \
        "local.symfony" \
        "local.traefik" \
        "local.whoami" \
        "localhost" \
        "127.0.0.1"
```

# Install
## Env variables
Dump the following files at the root of this project.

```dotenv
# nginx.env
APP_NGINX_HOST=local.symfony
APP_FPM_HOST=php
```

```dotenv
# nginx_h2.env
ENABLE_HTTP2=true
SSL_CERT=/ssl/local-cert.pem
SSL_KEY=/ssl/local-key.pem
```

```dotenv
# nginx_h3.env
HTTP3_PORT=9090
```

```dotenv
# php.env
PHP_XDEBUG_ENABLED=1
APP_SWITCH_ENV=true

# Host = docker network inspect "${NETWORK_NAME:?}" -f "{{range .IPAM.Config }}{{ .Gateway }}{{end}}"
# Port = ARBITRARY
XDEBUG_CONFIG=remote_host=172.28.0.4 remote_port=30093
```

```dotenv
# postgres.env
LC_ALL=C.UTF-8
POSTGRES_USER=symfony
POSTGRES_PASSWORD=symfony
POSTGRES_DB=symfony
```

```dotenv
# traefik.env
```

```dotenv
# vulcain.env
DEBUG=1
UPSTREAM=https://local.symfony
KEY_FILE=tls/local-key.pem
CERT_FILE=tls/local-cert.pem
ADDR=:8080
```

```dotenv
# blackfire.env
BLACKFIRE_SERVER_ID=
BLACKFIRE_SERVER_TOKEN=
BLACKFIRE_CLIENT_ID=
BLACKFIRE_CLIENT_TOKEN=
```
[See Blackfire chapter for more](#blackfire)

## Map hosts
```bash
# /etc/hosts
127.0.0.1 local.traefik
127.0.0.1 local.whoami
127.0.0.1 local.symfony
```

## Compiling the compose files
### Local
Create the `.env` file first.
You can create it:

```dotenv
#.env
## Required
COMPOSE_PROJECT_NAME=symfony-sandbox
# Path from the root of this project to the root of the symfony project
SYMFONY_PROJECT_PATH=../symfony-sandbox
# Run `mkcert -CAROOT` and copy the value inside `CA_ROOT_PATH`
CA_ROOT_PATH=/mkcert
```

```bash
$ docker-compose \
    -f ./docker-compose.yml \
    -f ./env/local/docker-compose.traefik.yml \
    -f ./env/local/docker-compose.local.yml \
    -f ./env/local/docker-compose.local.traefik.yml \
    config \
> ./docker-compose.compiled.yml
```

### Prod
Create the `.env` file first.
You can create it:

```dotenv
#.env
## Required
REGISTRY_BASE=YourRegistry
PROJECT_HOST=YourUrl
```

```bash
$ docker-compose \
    -f ./docker-compose.yml \
    -f ./env/prod/docker-compose.swarm.yml \
    -f ./env/prod/docker-compose.swarm.traefik.v2.yml \
    config \
> ./docker-compose.compiled.yml
```

## Running the containers
### Local
```bash
$ docker-compose -f ./docker-compose.compiled.yml pull; \
  docker-compose -f ./docker-compose.compiled.yml up -d --remove-orphans --build
```

The `pull` will show some errors. As long as it concerns `php` or `tools` it is fine. (mix of `build` + `image` in docker-compose).

### Prod
```bash
$ docker stack deploy \
    -c ./docker-compose.compiled.yml \
    --prune \
    --with-registry-auth \
  sandbox
```

## Setting up the project locally
### Use the `functions.sh`
This file is to ease the use of containers without thinking about it when developing.

```bash
$ source ./functions.sh
```

### Setting up the database
```bash
$ dev do:mi:mi -n; dev h:f:l -n
```

### Build assets
#### React app
```bash
$ yarn-react install
$ yarn-react dev # or "watch" or "production"
```
#### Vue app
```bash
$ yarn-vue install
$ yarn-vue dev # or "watch" or "production"
```

## Blackfire
Connect to [Blackfire docker integration documentation](https://blackfire.io/docs/integrations/docker/index) and copy paste your environments variables in `blackfire.env` file above.

:warning: For now Blackfire could not work with Xdebug enabled. Set `ENABLE_XDEBUG` to `false` if you want to profile with Blackfire.
