#!/bin/bash

docker volume create laravel
docker network create laravel

docker build --tag project:laravel ./laravel/