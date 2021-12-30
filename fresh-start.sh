#!/bin/bash

docker-compose down
docker-compose --f docker-compose-ok.yml up -d --build

while [ $(docker inspect --format "{{json .State.Health.Status }}" laravel-mysql) != "\"healthy\"" ]; do printf "."; sleep 1; done
docker exec laravel-php bash rebuild-db.sh
