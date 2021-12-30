#!/bin/bash

cd ./laravel-project

php artisan db:create
php artisan migrate:fresh
php artisan db:seed
