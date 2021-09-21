#!/bin/bash

docker rmi project:laravel project:nginx
docker volume rm laravel
docker network rm laravel

docker stop laravel-php laravel-nginx laravel-mysql

docker rm laravel-php
docker rm laravel-nginx
docker rm laravel-mysql