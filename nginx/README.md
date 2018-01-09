# Nexus Platform with Docker Support, behind Nginx

This is a template for deploying Nexus Repository Manager and IQ Server behind an NGINX proxy to offload SSL

I also add two aliases to my /etc/hosts file to match the names of the containers and simulate DNS from outside of docker host but this will setup and be accessible over http wtihout them:

```
127.0.0.1      localhost iq-server nexus
```

## Features

- Nexus Web UI with SSL accessible via https://nexus
- Nexus Web UI over http via http://nexus:8081 or http://localhost:8081
- Docker proxy group registry accessible via https://nexus:18443 (pull)
- Docker Private Registry accessible via https://nexus:5000  (push)
- IQ Server accessible via https://iq-server or http://localhost:8070

## Operations

To create and run the Nginx proxy, Nexus Repository Manager and IQ Servver, run:

```
./demo-setup.sh
```

To stop, use docker-compose:

```
docker-compose down
```

Subsequent runs can use docker-compose without the build for nginx or the need to create the persistent folders:

```
docker-compose up -d
```

## Ports

The ports are based on my own configuration but can easily be re-aligned via the nginx conf file. If you were previously using my setup with SSL built into Nexus then the big change is to remap 18443 and 5000 to http instead of https within Nexus. I've added some provisioning scripts to remove the need for manual configuration within Nexus. 18443 maps to my Docker-proxy group and 5000 maps to my docker-hosted repo. I run nexus on 8081 (to avoid a conflict with Jenkins) which can still be hot directly for non-https connections. For now the provisioning only does Docker config items but additional examples are in place.

## SSL Certificates

The Ngnix docker image build process generates insecure SSL certificates with fake location information and CNAME of localhost. Understand the risks of using these SSL certificates before proceeding. A deployed solution should use a valid CA certificate.


## Dynamic Configuration

Working examples of how to provision a new blobstore and create docker repos using it are in here and part of the setup. There are also placeholders for other formats like Maven, nnpm, etc...
