#!/usr/bin/env bash

# Creates directories to be mounted to containers as volumes
mkdir ~/iq-data ~/nexus-data

# Stands up test environment and builds nginix container to put our config in
docker-compose up -d --build

until curl --fail --insecure http://localhost:8081; do 
  sleep 5
done

#This needs to be changed but is left here as an example
curl -v -u admin:admin123 --insecure --header 'Content-Type: application/json' 'http://localhost/service/siesta/rest/v1/script' -d @nexus-repository/create-docker-proxy.json
curl -v -X POST -u admin:admin123 --insecure --header 'Content-Type: text/plain' 'http://localhost/service/siesta/rest/v1/script/CreateDockerProxy/run'

curl -v -u admin:admin123 --insecure --header 'Content-Type: application/json' 'http://localhost/service/siesta/rest/v1/script' -d @nexus-repository/create-docker-hosted.json
curl -v -X POST -u admin:admin123 --insecure --header 'Content-Type: text/plain' 'http://localhost/service/siesta/rest/v1/script/CreateDockerHosted/run'

curl -v -u admin:admin123 --insecure --header 'Content-Type: application/json' 'http://localhost/service/siesta/rest/v1/script' -d @nexus-repository/create-docker-group.json
curl -v -X POST -u admin:admin123 --insecure --header 'Content-Type: text/plain' 'http://localhost/service/siesta/rest/v1/script/CreateDockerGroup/run'