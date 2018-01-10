#!/bin/bash

#Note: defaults creds are baked in so this will work on a fresh instance
nexus() {
java -jar nexus-cli-1.0-SNAPSHOT-shaded.jar \
  -s http://localhost:8070 \
  $@
}

cd $(cd ${0%/*}; pwd)

echo "Importing license"
# Update this to point to your license placed in this folder
#nexus license install <your license file>
nexus license install sonatype-nexus-firewall-lifecycle-2017.lic

#these are our sample policies but you might have customized and exported your own so feel free to update
echo "Applying policies"
nexus policy import Sonatype-Sample-Policy-Set-1.22.json

cd ..
pwd