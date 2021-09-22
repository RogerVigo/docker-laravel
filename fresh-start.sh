#!/bin/bash

docker-compose down
docker-compose --f docker-compose-ok.yml up -d --build
