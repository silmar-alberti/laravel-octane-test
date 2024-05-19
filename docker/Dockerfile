FROM php:8.3-cli-alpine AS base
RUN set -xe; \
    # Install build dependencies
    apk --update --no-cache --virtual add \
    $PHPIZE_DEPS

FROM base as dev

WORKDIR /application

RUN set -eux; \
    apk add --update linux-headers; \
    pecl install xdebug; \
    docker-php-ext-enable xdebug; \
    mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini";

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

ENV PHP_IDE_CONFIG="serverName=laravel-octane"
COPY docker/dev/xdebug.ini /usr/local/etc/php/conf.d/z-xdebug.ini
COPY docker/dev/opcache.ini /usr/local/etc/php/conf.d/z-opcache.ini
