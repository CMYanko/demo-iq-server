FROM sonatype/nexus-iq-server
COPY config.yml /opt/sonatype/iq-server/

HEALTHCHECK CMD curl http://localhost:8071/ping