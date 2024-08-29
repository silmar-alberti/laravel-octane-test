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

FROM base as builder

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

WORKDIR /app
COPY . .
COPY .env.example /app/.env


ENV COMPOSER_ALLOW_SUPERUSER=1

RUN set -eux; \
    sed -i'' -e 's/^APP_ENV=.*/APP_ENV=production/' -e 's/^APP_DEBUG=.*/APP_DEBUG=false/' .env; \
    composer install -o --no-dev;


FROM base as prod

COPY --link docker/prod/php/opcache.ini $PHP_INI_DIR/conf.d/

WORKDIR /go/src/app/dist/app


WORKDIR /application

COPY . .
COPY --from=builder /app/vendor ./vendor

RUN rm -Rf tests/; \
    mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Change APP_ENV and APP_DEBUG to be production ready
RUN sed -i'' -e 's/^APP_ENV=.*/APP_ENV=production/' -e 's/^APP_DEBUG=.*/APP_DEBUG=false/' .env

ENTRYPOINT [ "/application/artisan" ]
CMD [ "octane:frankenphp", "--workers=10", "--max-requests=250","--host=0.0.0.0"]
