#!/usr/bin/env bash

# Creates directories to be mounted to containers as volumes
mkdir ~/iq-data ~/nexus-data

# Stands up test environment and builds nginix container to put our config in
docker-compose up -d --build

until curl --fail --insecure http://localhost:8081; do 
  sleep 1
done

#This needs to be changed but is left here as an example
./nexus-repoistory/provision.sh
