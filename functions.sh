#!/usr/bin/env bash

CURRENT_BASH=$(ps -p $$ | awk '{ print $4 }' | tail -n 1)
case "${CURRENT_BASH}" in
  -zsh|zsh)
    CURRENT_DIR=$(cd "$(dirname "${0}")" && pwd)
    ;;
  bash)
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
  docker exec -it cqrs_php sh -c "php $*"
}
export -f php

unalias composer 2>/dev/null >/dev/null || true
composer() {
  docker exec -it cqrs_composer sh -c "COMPOSER_MEMORY_LIMIT=-1 composer $*"
}
export -f composer

unalias pomm 2>/dev/null >/dev/null || true
pomm() {
  docker exec -it cqrs_php sh -c "./vendor/bin/pomm.php $*"
}
export -f pomm

unalias console 2>/dev/null >/dev/null || true
console() {
  php bin/console "$@"
}
export -f console

unalias phpunit 2>/dev/null >/dev/null || true
phpunit() {
  php vendor/bin/phpunit "$@"
}
export -f phpunit

unalias sf-check 2>/dev/null >/dev/null || true
sf-check() {
  php bin/symfony_requirements
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

unalias pgsql 2>/dev/null >/dev/null || true
pgsql() {
  source "${CURRENT_DIR}/postgres.env"
  docker exec -ti cqrs_postgres sh -c "psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} $*"
}
export -f pgsql

unalias pgsql-init 2>/dev/null >/dev/null || true
pgsql-init() {
  echo -e "\033[0;31mDATABASE SETUP - IN PROGRESS...\033[0m"
  docker cp "${CURRENT_DIR}/build/postgres/init.sql" "cqrs_postgres:/tmp/init.sql"
  docker cp "${CURRENT_DIR}/build/postgres/fixtures.sql" "cqrs_postgres:/tmp/fixtures.sql"

  source "${CURRENT_DIR}/postgres.env"
  docker exec -ti cqrs_postgres sh -c "psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} < /tmp/init.sql"
  docker exec -ti cqrs_postgres sh -c "psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} < /tmp/fixtures.sql"
  echo -e "\033[0;31mDATABASE SETUP - DONE !\033[0m\n"
}
export -f pgsql-init

unalias pgsql-reset 2>/dev/null >/dev/null || true
pgsql-reset() {
  echo -e "\033[0;31mDATABASE RESET - IN PROGRESS...\033[0m"
  docker cp "${CURRENT_DIR}/build/postgres/reset.sql" "cqrs_postgres:/tmp/reset.sql"

  source "${CURRENT_DIR}/postgres.env"
  docker exec -ti cqrs_postgres sh -c "psql -U ${POSTGRES_USER} -d ${POSTGRES_DB} < /tmp/reset.sql"
  echo -e "\033[0;31mDATABASE RESET - DONE !\033[0m\n"
}
export -f pgsql-reset
