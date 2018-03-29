#!/usr/bin/env bash

# Creates directories to be mounted to containers as volumes
mkdir ~/iq-data ~/nexus-data

# Stands up test environment and builds nginix container to put our config in
docker-compose up -d

until curl --fail --insecure http://localhost:8081; do 
  sleep 5
done

#import license and policies to IQ server
./iq-server/config-iq.sh

#Create Docker repos and group
cd nexus-repository
./create.sh blobs.json
./run.sh myBlobs

./create.sh docker.json
./run.sh Docker

# ./create.sh maven.json
# ./run.sh Maven