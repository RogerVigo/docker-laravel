#!/bin/bash

docker rmi project:laravel
docker volume rm laravel
docker network rm laravel