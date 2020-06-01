#!/bin/bash

docker rmi project:laravel project:nginx
docker volume rm laravel
docker network rm laravel