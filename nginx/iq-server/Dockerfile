FROM sonatype/nexus-iq-server:1.45.0
COPY config.yml /etc/nexus-iq-server/

HEALTHCHECK CMD curl http://localhost:8071/ping