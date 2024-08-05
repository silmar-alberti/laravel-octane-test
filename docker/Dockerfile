FROM dunglas/frankenphp:1.2-php8.3-alpine as base

WORKDIR /application

ENV TZ=UTC

RUN apk add --no-cache --virtual postgresql-dev libpq-dev; \
    install-php-extensions opcache pdo pdo_pgsql

RUN docker-php-ext-configure pcntl --enable-pcntl; \
    install-php-extensions pcntl;

FROM base as dev

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
COPY --link docker/dev/php/* $PHP_INI_DIR/conf.d/

RUN mv "$PHP_INI_DIR/php.ini-development" "$PHP_INI_DIR/php.ini"; \
    install-php-extensions xdebug
