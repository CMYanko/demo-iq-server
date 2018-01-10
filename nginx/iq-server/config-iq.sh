#!/bin/bash

nexus() {
java -jar nexus-cli-1.0-SNAPSHOT-shaded.jar \
  -s http://localhost:8070 \
  $@
}

#cd $(cd ${0%/*}; pwd)

echo "Importing license"
#Update this to point to your license
nexus license install sonatype-nexus-firewall-lifecycle-2017.lic


echo "Applying policies"
nexus policy import Sonatype-Sample-Policy-Set-1.22.json
