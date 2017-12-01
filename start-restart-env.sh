# Use this file if you're not using docker-compose

docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker ps
docker network create demo-net
docker pull bradbeck/nexus-https
docker pull sonatype/nexus-iq-server
docker run -d -p 8070:8070 -v ~/iq-data:/sonatype-work --net demo-net --name iq-server cmyanko/demo-iq-server
docker run -d -p 8081:8081 -p 8443:8443 -p18443:18443 -p18444:18444 --net demo-net -v ~/nexus-data:/nexus-data -v ~/nexus-ssl:/opt/sonatype/nexus/etc/ssl --name nexus3 bradbeck/nexus-https
docker ps