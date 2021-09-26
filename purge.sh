#!/bin/bash

docker volume rm laravel
docker network rm laravel

docker stop laravel-php laravel-nginx laravel-mysql laravel-redis

docker rm laravel-php
docker rm laravel-nginx
docker rm laravel-mysql
docker rm laravel-redis

docker rmi project:laravel project:nginx