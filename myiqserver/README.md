# Custom IQ Server Image

A Dockerfile for creating a custom image based on the Official Image

FROM sonatype/nexus-iq-server
COPY config.yml /opt/sonatype/iq-server/

HEALTHCHECK CMD curl http://localhost:8071/ping
