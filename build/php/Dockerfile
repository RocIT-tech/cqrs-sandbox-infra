FROM rocit/php:7.4 as php

#---------------
# Composer
#---------------
FROM php as tools

USER root

# Composer
COPY --chown=app:app --from=composer:latest /usr/bin/composer /usr/bin/composer

# Code Coverage
RUN pecl install pcov && docker-php-ext-enable pcov

USER app
