
.PHONY: setup
setup: setup-env build up composer-install fix-permissions git-ignore-filemode setup-key

build:
	docker compose build

up:
	docker compose up php -d

up-prod:
	docker compose up php-prod -d

down:
	docker compose down

restart:
	docker compose restart

php: up
	docker compose exec php sh

cli:
	docker compose run --entrypoint=sh -T php

test: up
	docker compose exec -T --entrypoint php laravel-octane-container ./vendor/bin/phpunit

composer-install: up
	docker compose run --entrypoint composer php install

fix-permissions: up
	docker compose exec -T php chmod 777 -R /application/storage/ /application/vendor/

setup-env:
	test -f .env || cp .env.example .env

setup-key:
	docker compose exec -T laravel-octane-container chmod +x ./artisan
	docker compose exec -T laravel-octane-container ./artisan key:generate

git-ignore-filemode:
	git config core.fileMode false
