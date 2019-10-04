FROM rocit/php:7.3 as php

#---------------
# Composer
#---------------
FROM php as composer

USER app

COPY --chown=app:app --from=composer:latest /usr/bin/composer /usr/bin/composer
