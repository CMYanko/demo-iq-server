FROM sonatype/nexus-iq-server:1.44.0
COPY config.yml /opt/sonatype/iq-server/

HEALTHCHECK CMD curl http://localhost:8071/ping