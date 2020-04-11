#!/usr/bin/env bash

CURRENT_BASH=$(ps -p $$ | awk '{ print $4 }' | tail -n 1)
case "${CURRENT_BASH}" in
  -zsh|zsh)
    CURRENT_DIR=$(cd "$(dirname "${0}")" && pwd)
    ;;
  -bash|bash)
    CURRENT_DIR=$(cd "$(dirname ${BASH_SOURCE[0]})" && pwd)
    ;;
  *)
    echo 1>&2
    echo -e "\033[0;31m\`${CURRENT_BASH}\` does not seems to be supported\033[0m" 1>&2
    echo 1>&2
    return 1
    ;;
esac

unalias php 2>/dev/null >/dev/null || true
php() {
  docker exec -it symfony_php sh -c "php $*"
}
export -f php

unalias composer 2>/dev/null >/dev/null || true
composer() {
  docker exec -it symfony_tools sh -c "COMPOSER_MEMORY_LIMIT=-1 composer $*"
}
export -f composer

unalias console 2>/dev/null >/dev/null || true
console() {
  php bin/console "$@"
}
export -f console

unalias phpunit 2>/dev/null >/dev/null || true
phpunit() {
  docker exec -it symfony_tools sh -c "php ./vendor/bin/phpunit $*"
}
export -f phpunit

unalias openapi 2>/dev/null >/dev/null || true
openapi() {
  docker exec -it symfony_openapi_tools sh -c "openapi-cli-tool $*"
}
export -f openapi

unalias openapi-build 2>/dev/null >/dev/null || true
openapi-build() {
  # trick because https://github.com/docker/compose/issues/2854 is not resolved (see end of thread)
  eval $(cat "${CURRENT_DIR:?}/.env" | grep -v 'CA_ROOT_PATH' | perl -pe 's#^#export #')
  openapi bundle -t json ./reference/Symfony-Sandbox.v1.yaml > "${CURRENT_DIR:?}/${SYMFONY_PROJECT_PATH:?}/doc/openapi/openapi.json"
}
export -f openapi-build

unalias sf-check 2>/dev/null >/dev/null || true
sf-check() {
  php vendor/bin/requirements-checker
}
export -f sf-check

unalias dev 2>/dev/null >/dev/null || true
dev() {
  console --env=dev "$@"
}
export -f dev

unalias prod 2>/dev/null >/dev/null || true
prod() {
  console --env=prod "$@"
}
export -f prod

unalias test 2>/dev/null >/dev/null || true
test() {
  console --env=test "$@"
}
export -f test

unalias pgsql 2>/dev/null >/dev/null || true
pgsql() {
  source "${CURRENT_DIR}/postgres.env"
  docker exec -ti symfony_postgres sh -c "psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} $*"
}
export -f pgsql

unalias yarn-react 2>/dev/null >/dev/null || true
yarn-react() {
  docker exec -ti symfony_node sh -c "cd ./webpack/react && yarn $*"
}
export -f yarn-react

unalias yarn-vue 2>/dev/null >/dev/null || true
yarn-vue() {
  docker exec -ti symfony_node sh -c "cd ./webpack/vue && yarn $*"
}
export -f yarn-vue
