# LARAVEL project with DOCKER

## Introduction

This project is intended to create a laravel project withing a docker container. It also has the possibility to link a
existing project. In the following sections will appear different explanations for different contexts

## Create new project from scratch
The project contains some bash scripts

Script      | Functionality
-------     | -------------
config.sh   | Creates the necessary images and set up everything
run.sh      | Once everything is ready, runs docker compose to start services
purge.sh    | Deletes the installation (docker image included)

You may also have to add the following line to your hosts file:

In file `/etc/hosts` add `127.0.0.1     project`

