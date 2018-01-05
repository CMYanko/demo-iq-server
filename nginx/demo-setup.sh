#!/usr/bin/env bash

# Creates directories to be mounted to containers as volumes
mkdir ~/iq-data ~/nexus-data

# Stands up test environment and builds nginix container to put our config in
docker-compose up -d --build

until curl --fail --insecure http://localhost:8081; do 
  sleep 5
done

#Create Docker repos and group
#curl -v -u admin:admin123 --insecure --header 'Content-Type: application/json' 'https://localhost/service/siesta/rest/v1/script' -d @nexus-repository/docker.json
#curl -v -X POST -u admin:admin123 --insecure --header 'Content-Type: text/plain' 'https://localhost/service/siesta/rest/v1/script/Docker/run'
cd nexus-repository
./create.sh docker.json
./run.sh Docker