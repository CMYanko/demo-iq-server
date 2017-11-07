#!/usr/bin/env bash

# Creates directories to be mounted to containers as volumes
mkdir ~/iq-data ~/nexus-data
cp -R ./nexus-ssl ~/nexus-ssl

# Stands up test environment
docker-compose up -d