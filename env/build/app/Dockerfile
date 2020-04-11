FROM alpine/git as git

ARG SSH_PRIVATE_KEY
ARG CLONE_REPOSITORY
ARG CLONE_BRANCH="master"

RUN mkdir /root/.ssh/ && \
    echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa && \
    touch /root/.ssh/known_hosts && \
    ssh-keyscan $(echo "${CLONE_REPOSITORY:?}" | perl -pe 's#^[^@]*@([^:]*):.*$#$1#') >> /root/.ssh/known_hosts

WORKDIR /

RUN git clone --single-branch --branch ${CLONE_BRANCH} ${CLONE_REPOSITORY:?} /project

#---------------
# Build Assets
#---------------
FROM node:12-stretch as assets

ARG YARN_COMMAND=dev

USER node

RUN mkdir -p /home/node/app /home/node/public/build/react /home/node/public/build/vue

WORKDIR /home/node/app

COPY --chown=node:node --from=git /project/webpack/ /home/node/app/

RUN (cd ./react && yarn install) \
    && (cd ./vue && yarn install)

COPY --chown=node:node --from=git /project /home/node/app/

RUN (cd ./react && yarn ${YARN_COMMAND}) \
    && (cd ./vue && yarn ${YARN_COMMAND})

#---------------
# Base PHP
#---------------
FROM rocit/php:7.4 as base_php

USER app

WORKDIR /var/www/html

#---------------
# Build PHP
#---------------
FROM base_php as build_php

ARG SERVER_ENV=dev
ARG SYMFONY_ENV=dev

COPY --chown=app:app --from=composer:latest /usr/bin/composer /usr/bin/composer
COPY --chown=app:app --from=git /project/composer.* /var/www/html/

RUN composer install --no-autoloader --no-scripts --no-interaction --no-suggest --quiet

#COPY --chown=app:app ./config/${SERVER_ENV}/* /var/www/html/
COPY --chown=app:app --from=git /project/ /var/www/html/

RUN composer install --optimize-autoloader --no-interaction --no-suggest && \
	composer dump-env ${SYMFONY_ENV} && \
	./bin/console cache:clear && \
	./bin/console assets:install public

#---------------
# PHP
#---------------
FROM base_php as php

COPY --chown=app:app --from=build_php /var/www/html     /var/www/html
COPY --chown=app:app --from=assets /home/node/public/   /var/www/html/public/

#---------------
# NginX
#---------------
FROM rocit/nginx:1.17-symfony4 as nginx

RUN rm -rf html/public

COPY --chown=www-data:www-data --from=php /var/www/html/public    /var/www/html/public
COPY --chown=www-data:www-data --from=assets /home/node/public/   /var/www/html/public/
