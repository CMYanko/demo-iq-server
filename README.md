# CMYanko/demo-iq-server

A Docker-compose file and setup scripts to streamline a default configuration Nexus Platform Evaluation, PoC or Demo Environment.  Details for setting up a demo environment are [here](https://github.com/CMYanko/demo-iq-server/blob/master/DEMO_ENV.md).

For PoC's and or custom config'd demo environments you'll likely want your own tag and publish to a private repo. I've created a seperate folder with a Dockerfile making a custom image based on our official image.

run the demo-setup script to create folders and copy in a self signed cert then call the docker-compose file. The '-d' detaches it from the console.

```
#!/usr/bin/env bash

# Creates directories to be mounted to containers as volumes
mkdir ~/iq-data ~/nexus-data
cp -R ./nexus-ssl ~/nexus-ssl

# Stands up test environment
docker-compose up -d
```

To shut down the environment run

```
docker-compose down
```


## Notes

* Default credentials are: `admin` / `admin123`

* All logs are directed to stdout:

  ```
  $ docker logs -f iq-server
  ```
    [Kitematic](https://kitematic.com/) is also great for seeing container logs!
  
* Installation of IQ Server is to `/opt/sonatype/iq-server`.  

* A persistent directory, `/sonatype-work`, is used for report and DB storage.
  This directory needs to be writable by the IQ server process, which runs as
  UID 201.

* An environment variable, `JVM_OPTIONS`, used to control the JVM arguments

  ```
  $ docker run -d -p 8070:8070 --name iq-server -e JVM_OPTIONS="-server -Xmx2g" CMYanko/demo-iq-server
  ```


### Persistent Data

There are two general approaches to handling persistent storage requirements
with Docker. See [Managing Data in Containers](https://docs.docker.com/userguide/dockervolumes/)
for additional information.

  1. *Use a data volume container*.  Since data volumes are persistent
  until no containers use them, a container can created specifically for 
  this purpose.  This is the recommended approach.  

  ```
  $ docker run -d --name iq-data CMYanko/demo-iq-server echo "data-only container for IQ server"
  $ docker run -d -p 8070:8070 --name iq-server --volumes-from iq-data CMYanko/demo-iq-server
  ```

  2. *Mount a host directory as the volume*.  This is not portable, as it
  relies on the directory existing with correct permissions on the host.
  However it can be useful in certain situations where this volume needs
  to be assigned to certain specific underlying storage.  

  ```
  $ mkdir /some/dir/iq-data && chown -R 201 /some/dir/iq-data
  $ docker run -d -p 8070:8070 --name iq-server -v /some/dir/iq-data:/sonatype-work CMYanko/demo-iq-server
  ```

### Changing IQ Server Configuration

There are two primary ways to update the configuration for demo-iq-server. 

*1) Pass parameters to the JVM*.  For instance, to change the `baseUrl`:

```
  $ docker run -d -e JVM_OPTIONS="dw.baseUrl=http://someaddress:8060" CMYanko/demo-iq-server
```

*2} Create an image w/ updated `config.yml`*:

* Create a new `config.yml`
* Create a `Dockerfile`:
```
  FROM CMYanko/demo-iq-server
  ADD config.yml /opt/sonatype/iq-server/
  
  HEALTHCHECK CMD curl http://localhost:8071/ping
```
* Create a local image:
```
  $ docker build -t my-iq-server .
```
* Use this docker image as you normally would: `docker run -d my-iq-server`
* ...or make a copy of the docker-compose file and update wioth your container name.


