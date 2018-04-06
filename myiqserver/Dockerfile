FROM sonatype/nexus-iq-server
ADD config.yml /opt/sonatype/iq-server/

HEALTHCHECK CMD curl http://localhost:8071/ping